Strict

Import flixel

Import playstate
Import assets
Import programstack
Import player
Import display
Import box

Class LevelMap Extends FlxGroup Implements FlxTileHitListener, FlxOverlapNotifyListener

	Field programStack:ProgramStack
	
	Field player:Player
	
	Field map:FlxTilemap
	
Private
	Const _CHIP_ID:Int = 1
	
	Const _BUTTON_ID:Int = 2
	
	Const _BOX_ID:Int = 3

	Field _chip:FlxSprite
	
	Field _button:FlxSprite
	
	Field _boxes:FlxGroup
	
	Field _context:Display
	
	Field _hasLaser:Bool
	
	Field _laserDisabled:Bool
	
	Field _info:String[]
	
	Field _level:Int
	
	Field robotCrashListener:RobotCrashListener

Public
	Method New(context:Display)
		_context = context
	
		player = New Player(0, 0, Self)
		player.Kill()
		programStack = New ProgramStack(player)
		
		_chip = New FlxSprite(0, 0, Assets.SPRITE_CHIP)
		_chip.Kill()
		_chip.ID = _CHIP_ID
		
		_button = New FlxSprite()
		_button.LoadGraphic(Assets.SPRITE_BUTTON, True,, PlayState.TILE_SIZE, PlayState.TILE_SIZE)
		_button.Kill()
		_button.ID = _BUTTON_ID
		
		_boxes = New FlxGroup()
			
		map = New FlxTilemap()
		
		Add(map)
		Add(_button)
		Add(_boxes)
		Add(_chip)
		Add(player)
		
		'programStack must be last. Update tweens reason
		Add(programStack)
		
		robotCrashListener = New RobotCrashListener(programStack)
	End Method
	
	Method LoadLevel:Void(level:Int)
		_hasLaser = False
		_laserDisabled = False
		
		_chip.Kill()
		_button.Kill()
		_boxes.Kill()
		
		map.LoadMap(FlxAssetsManager.GetString("level_" + level), Assets.TILESET, PlayState.TILE_SIZE, PlayState.TILE_SIZE,, 0, 0, 3)
		
		Local tiles:Stack<Int>
		Local tilesCoord:Stack<FlxPoint>
		
		For Local i:Int = 4 To 7
			tiles = map.GetTileInstances(i)
			tilesCoord = map.GetTileCoords(i, False)
			
			If (tiles) Then
				map.SetTileByIndex(tiles.Get(0), 0)
				player.Reset(tilesCoord.Get(0).x, tilesCoord.Get(0).y)
				
				Select i
					Case 4
						player.angle = 0
						
					Case 5
						player.angle = 180
						
					Case 6
						player.angle = 90
						
					Case 7
						player.angle = 270
				End Select
			End If
		Next

		For Local i:Int = 12 To 13
			tiles = map.GetTileInstances(i)
			tilesCoord = map.GetTileCoords(i, False)
			
			If (tiles) Then
				_chip.Reset(tilesCoord.Get(0).x, tilesCoord.Get(0).y)
			
				Select i
					Case 12
						map.SetTileByIndex(tiles.Get(0), 0)
						
					Case 13
						map.SetTileByIndex(tiles.Get(0), 28)
				End Select
			End If
		Next
		
		tiles = map.GetTileInstances(18)
		_hasLaser = (tiles <> Null)
		
		If ( Not _hasLaser) Then
			tiles = map.GetTileInstances(21)
			_hasLaser = (tiles <> Null)
		End If
		
		If (_hasLaser) Then
			tiles = map.GetTileInstances(8)
			tilesCoord = map.GetTileCoords(8, False)
			
			If (tiles) Then
				_button.Reset(tilesCoord.Get(0).x, tilesCoord.Get(0).y)
				map.SetTileByIndex(tiles.Get(0), 0)
			End If
		End If
		
		tiles = map.GetTileInstances(10)
		tilesCoord = map.GetTileCoords(10, False)
		
		If (tiles) Then
			_boxes.Revive()		
			Local box:Box
			
			Local offset:Int = 0
			For Local i:Int = EachIn tiles
				map.SetTileByIndex(i, 0)
				box = Box(_boxes.Recycle(ClassInfo(Box.ClassObject)))
				box.LoadGraphic(Assets.SPRITE_BOX)
				box.ID = _BOX_ID
				box.active = False
				box.Reset(tilesCoord.Get(offset).x, tilesCoord.Get(offset).y)
				
				offset += 1
			Next
		End If
		
		map.SetTileProperties(3, FlxObject.ANY, robotCrashListener)
		map.SetTileProperties(24, FlxObject.ANY, Self,, 16)
		map.SetTileProperties(11, FlxObject.NONE)
		map.SetTileProperties(14, FlxObject.NONE,,, 4)
		
		_info = FlxAssetsManager.GetString("console_" + level).Split("~n")
		_level = level
		Console.GetInstance().Title("Stage " + level)
		PutInfo()
		
		programStack.Clear()
	End Method
	
	Method ReloadLevel:Void()
		LoadLevel(_level)
	End Method
	
	Method IsValid:Bool()
		Local index:Int = map.GetTile( (player.x + player.width * 0.5) / PlayState.TILE_SIZE, (player.y + player.height * 0.5) / PlayState.TILE_SIZE)
		Return(index = 2)
	End Method
	
	Method OnTileHit:Void(tile:FlxTile, object:FlxObject)
		If (object.ID = _BOX_ID) Then
			If (tile.index > 23 And tile.index < 40) Then
				object.allowCollisions = FlxObject.NONE
				Box(object).hole.x = tile.x
				Box(object).hole.y = tile.y
			End If
		End If
	End Method
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		Select object2.ID
			Case _CHIP_ID
				object2.Kill()
				_context.help.OpenNextModule()
			Case _BUTTON_ID
				_laserDisabled = True
		End Select
	End Method
	
	Method GetBox:Box()
		Local index:Int = 0
		Local x:Int
		Local y:Int
	
		Select player.angle
			Case 0
				x = player.x
				y = player.y - player.height
				
			Case 90, -270
				x = player.x + player.width
				y = player.y

			Case 180, -180
				x = player.x
				y = player.y + player.height
			
			Case 270, -90
				x = player.x - player.width
				y = player.y
		End Select
		
		Local box:Box
		Local p:FlxPoint = New FlxPoint(x + PlayState.TILE_SIZE * 0.5, y + PlayState.TILE_SIZE * 0.5)
		
		For Local b:FlxBasic = EachIn _boxes
			box = Box(b)
			
			If (box.OverlapsPoint(p)) Exit
			box = Null
		Next
		
		Return box
	End Method
	
	Method Update:Void()
		_laserDisabled = False
		FlxG.Collide(_boxes, map)
		FlxG.Collide(_boxes, _boxes)
		
		For Local b:FlxBasic = EachIn _boxes
			If (b.active) Then
				Local box:Box = Box(b)
				
				If (box.hole.x > 0) Then
					If (Abs(box.x - box.hole.x) <= Abs(box.x - box.last.x) And Abs(box.y - box.hole.y) <= Abs(box.y - box.last.y)) Then
						map.SetTile(box.hole.x / PlayState.TILE_SIZE, box.hole.y / PlayState.TILE_SIZE, 11)
						box.tween.Finish()
						box.Kill()
					End If
				End If
			End If
		Next

		Super.Update()
		FlxG.Collide(player, map)
		FlxG.Collide(player, _boxes)
		FlxG.Overlap(player, _chip, Self)
		
		If (_hasLaser) Then
			FlxG.Overlap(player, _button, Self)
			FlxG.Overlap(_boxes, _button, Self)
			
			If (_button.Frame = 0 And _laserDisabled) Then
				_button.Frame = 1
				DisableLaser()
			ElseIf(_button.Frame = 1 And Not _laserDisabled) Then
				_button.Frame = 0
				EnableLaser()
			End If
		End If
		
		If (player.x < 0 Or player.x > map.width - PlayState.TILE_SIZE Or player.y < 0 Or player.y > map.height - PlayState.TILE_SIZE) Then
			programStack.Stop()
			player.Reset(player.last.x, player.last.y)
		End If
	End Method
	
	Method DisableLaser:Void()
		Local tiles:Stack<Int>
	
		For Local i:Int = 18 To 23
			tiles = map.GetTileInstances(i)
			
			If (tiles) Then
				Select i
					Case 18
						map.SetTileByIndex(tiles.Get(0), 16)
						
					Case 20
						map.SetTileByIndex(tiles.Get(0), 17)
						
					Case 21
						map.SetTileByIndex(tiles.Get(0), 14)
						
					Case 23
						map.SetTileByIndex(tiles.Get(0), 15)
						
					Case 19
						For Local t:Int = EachIn tiles
							map.SetTileByIndex(t, 40)
						Next
						
					Case 22
						For Local t:Int = EachIn tiles
							map.SetTileByIndex(t, 41)
						Next
				End Select
			End If
		Next
	End Method
	
	Method EnableLaser:Void()
		Local tiles:Stack<Int>
	
		For Local i:Int = 14 To 17
			tiles = map.GetTileInstances(i)
			
			If (tiles) Then
				Select i
					Case 16
						map.SetTileByIndex(tiles.Get(0), 18)
						
					Case 17
						map.SetTileByIndex(tiles.Get(0), 20)
						
					Case 14
						map.SetTileByIndex(tiles.Get(0), 21)
						
					Case 15
						map.SetTileByIndex(tiles.Get(0), 23)

				End Select
			End If
		Next
		
		For Local i:Int = 40 To 41
			tiles = map.GetTileInstances(i)
			
			If (tiles) Then
				Select i						
					Case 40
						For Local t:Int = EachIn tiles
							map.SetTileByIndex(t, 19)
						Next
						
					Case 41
						For Local t:Int = EachIn tiles
							map.SetTileByIndex(t, 22)
						Next
				End Select
			End If	
		Next
	End Method
	
	Method PutInfo:Void()
		Local c:Console = Console.GetInstance()
		c.Empty()
		
		For Local s:String = EachIn _info
			c.Push(s)
		Next
	End Method

End Class

Class RobotCrashListener Implements FlxTileHitListener

Private
	Field _stack:ProgramStack
	
Public
	Method New(stack:ProgramStack)
		_stack = stack
	End Method
	
	Method OnTileHit:Void(tile:FlxTile, object:FlxObject)
		_stack.Stop("collision occured")
	End Method

End Class
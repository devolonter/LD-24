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
	Field _chip:FlxSprite
	
	Field _box:Box
	
	Field _context:Display

Public
	Method New(context:Display)
		_context = context
	
		player = New Player(0, 0, Self)
		programStack = New ProgramStack(player)
		
		_chip = New FlxSprite(0, 0, Assets.SPRITE_CHIP)
		_chip.Kill()
		
		_box = New Box(0, 0, Assets.SPRITE_BOX)
		_box.tween.complete = programStack
		_box.Kill()
			
		map = New FlxTilemap()
		
		Add(map)
		Add(player)
		Add(programStack)
		Add(_chip)
		Add(_box)
	End Method
	
	Method LoadLevel:Void(level:Int)
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
		
		map.SetTileProperties(24, FlxObject.ANY, Self,, 16)
		map.SetTileProperties(11, FlxObject.NONE)
	End Method
	
	Method IsValid:Bool()
		Local index:Int = map.GetTile( (player.x + player.width * 0.5) / PlayState.TILE_SIZE, (player.y + player.height * 0.5) / PlayState.TILE_SIZE)
		Return(index = 2)
	End Method
	
	Method OnTileHit:Void(tile:FlxTile, object:FlxObject)
		If (tile.index >= 23) Then
			_box.allowCollisions = FlxObject.NONE
			_box.hole.x = tile.x
			_box.hole.y = tile.y
		End If
	End Method
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		object2.Kill()
		_context.help.OpenNextModule()
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
			
				index = map.GetTile(player.x / PlayState.TILE_SIZE, (player.y + player.height) / PlayState.TILE_SIZE)
			
			Case 270, -90
				x = player.x - player.width
				y = player.y
		End Select
	
		index = map.GetTile(x / PlayState.TILE_SIZE, y / PlayState.TILE_SIZE)
	
		If (index = 10) Then
			_box.Reset(x, y)
			_box.Revive()
			map.SetTile(x / PlayState.TILE_SIZE, y / PlayState.TILE_SIZE, 0)
			
			Return _box
		Else
			Return Null
		End If
		
		
	End Method
	
	Method Update:Void()
		FlxG.Collide(_box, map)
		
		If (_box.alive) Then
			If (Abs(_box.x - _box.hole.x) <= Abs(_box.x - _box.last.x) And Abs(_box.y - _box.hole.y) <= Abs(_box.y - _box.last.y)) Then
				map.SetTile(_box.hole.x / PlayState.TILE_SIZE, _box.hole.y / PlayState.TILE_SIZE, 11)
				_box.tween.Finish()
				_box.allowCollisions = FlxObject.ANY
				_box.Kill()
			End If
		End If
	
		Super.Update()

		FlxG.Collide(player, map)
		FlxG.Overlap(player, _chip, Self)
	End Method

End Class
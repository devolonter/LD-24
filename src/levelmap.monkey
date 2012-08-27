Strict

Import flixel

Import playstate
Import assets
Import programstack
Import player
Import display

Class LevelMap Extends FlxGroup Implements FlxTileHitListener, FlxOverlapNotifyListener

	Field programStack:ProgramStack
	
	Field player:Player
	
Private
	Field _map:FlxTilemap
	
	Field _chip:FlxSprite

Public
	Method New()
		player = New Player(0, 0, _map)
		programStack = New ProgramStack(player)
		
		_chip = New FlxSprite(0, 0, Assets.SPRITE_CHIP)
		_chip.Kill()
			
		_map = New FlxTilemap()
		
		Add(_map)
		Add(player)
		Add(programStack)
		Add(_chip)
	End Method
	
	Method LoadLevel:Void(level:Int)
		_map.LoadMap(FlxAssetsManager.GetString("level_" + level), Assets.TILESET, PlayState.TILE_SIZE, PlayState.TILE_SIZE,, 0, 0, 3)
		
		Local tiles:Stack<Int>
		Local tilesCoord:Stack<FlxPoint>
		
		For Local i:Int = 4 To 7
			tiles = _map.GetTileInstances(i)
			tilesCoord = _map.GetTileCoords(i, False)
			
			If (tiles) Then
				_map.SetTileByIndex(tiles.Get(0), 0)
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
			tiles = _map.GetTileInstances(i)
			tilesCoord = _map.GetTileCoords(i, False)
			
			If (tiles) Then
				_chip.Reset(tilesCoord.Get(0).x, tilesCoord.Get(0).y)
			
				Select i
					Case 12
						_map.SetTileByIndex(tiles.Get(0), 0)
						
					Case 13
						_map.SetTileByIndex(tiles.Get(0), 28)
				End Select
			End If
		Next
	End Method
	
	Method IsValid:Bool()
		Local index:Int = _map.GetTile( (player.x + player.width * 0.5) / PlayState.TILE_SIZE, (player.y + + player.height * 0.5) / PlayState.TILE_SIZE)
		Return(index = 2)
	End Method
	
	Method OnTileHit:Void(tile:FlxTile, object:FlxObject)
		
	End Method
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		object2.Kill()
	End Method
	
	Method Update:Void()
		Super.Update()
		FlxG.Collide(player, _map)
		FlxG.Overlap(player, _chip, Self)
	End Method

End Class
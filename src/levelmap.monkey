Strict

Import flixel

Import playstate
Import assets

Class LevelMap Extends FlxGroup
	
Private
	Field _map:FlxTilemap
	
Public
	Method New()		
		_map = New FlxTilemap()
		_map.LoadMap(FlxAssetsManager.GetString("level_1"), Assets.TILESET, PlayState.TILE_SIZE, PlayState.TILE_SIZE,, 0, 0, 3)		
		Add(_map)
	End Method

End Class
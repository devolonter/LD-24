Strict

Import flixel

Import levelmap
Import playstate
Import assets

Class Player Extends FlxSprite

Private
	Field _context:LevelMap
	
Public
	Method New(x:Float, y:Float, context:LevelMap)
		_context = context
		LoadGraphic(Assets.SPRITE_PLAYER,,, PlayState.TILE_SIZE, PlayState.TILE_SIZE)
	End Method
	
	Method Context:Void(context:LevelMap) Property
		_context = context
	End Method
	
	Method Context:LevelMap() Property
		Return _context
	End Method

End Class
Strict

Import flixel

Import levelmap
Import playstate
Import assets

Class Player Extends FlxSprite

Private
	Field _context:FlxTilemap
	
Public
	Method New(x:Float, y:Float, context:FlxTilemap)
		_context = context
		LoadGraphic(Assets.SPRITE_PLAYER,,, PlayState.TILE_SIZE, PlayState.TILE_SIZE)
	End Method
	
	Method Context:Void(context:FlxTilemap) Property
		_context = context
	End Method
	
	Method Context:FlxTilemap() Property
		Return _context
	End Method

End Class
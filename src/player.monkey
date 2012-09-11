Strict

Import flixel

Import levelmap
Import playstate
Import assets

Class Player Extends FlxSprite

Private
	Field _context:LevelMap
	
	Field _engine:FlxSound
	
Public
	Method New(x:Float, y:Float, context:LevelMap)
		_context = context
		LoadGraphic(Assets.SPRITE_PLAYER,,, PlayState.TILE_SIZE, PlayState.TILE_SIZE)
		_engine = FlxG.LoadSound(Assets.SOUND_MOVE,, True)
	End Method
	
	Method Context:Void(context:LevelMap) Property
		_context = context
	End Method
	
	Method Context:LevelMap() Property
		Return _context
	End Method
	
	Method Run:Void()
		_engine.Play(True)
	End Method
	
	Method Stop:Void()
		_engine.Pause()
	End Method

End Class
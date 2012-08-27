Strict

Import flixel


Class Caret Extends FlxSprite

Private
	Field _tween:NumTween
	
Public
	Method New(x:Float, y:Float, charWidth:Int, charHeight:Int)
		Super.New(x, y)
		MakeGraphic(charWidth, charHeight * 0.5, $FF5CE227)
		offset.y = -charHeight
		
		_tween = New NumTween(Null, FlxTween.PINGPONG)
		_tween.Tween(1, 0, 0.25, Ease.SineInOut)
		AddTween(_tween, True)
	End Method
	
	Method Update:Void()
		Super.Update()
		Alpha = _tween.value
	End Method

End Class
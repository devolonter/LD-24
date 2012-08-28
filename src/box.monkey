Strict

Import flixel

Class Box Extends FlxSprite
	
	Field hole:FlxPoint
	
	Field tween:LinearMotion
	
	Method New(x:Int, y:Int, graphic:String)
		Super.New(x, y, graphic)
		hole = New FlxPoint()
		tween = New LinearMotion()
		tween.SetObject(Self)
		immovable = False
		AddTween(tween)
	End Method

End Class
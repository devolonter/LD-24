Strict

Import flixel

Class Box Extends FlxSprite

	Global ClassObject:Object
	
	Field hole:FlxPoint
	
	Field tween:LinearMotion
	
	Method New(x:Int = 0, y:Int = 0, graphic:String = "")
		Super.New(x, y, graphic)
		hole = New FlxPoint(-1, -1)
		tween = New LinearMotion()
		tween.SetObject(Self)
		immovable = False
		AddTween(tween)
	End Method

End Class
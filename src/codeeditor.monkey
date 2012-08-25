Strict

Import flixel

Import assets

Class CodeEditor Extends FlxGroup

	Field x:Float
	
	Field y:Float
	
	Field width:Float
	
	Field height:Float
	
	Method New(x:Float, y:Float, width:Float, height:Float)
		Self.x = x
		Self.y = y
		Self.width = width
		Self.height = height
		
		Local title:FlxText = New FlxText(x + 10, y + 10, width - 20, "MICRO EVO IDE V24 LD:")
		title.SetFormat(Assets.FONT_PROFONT, 18)
		Add(title)
	End Method

End Class
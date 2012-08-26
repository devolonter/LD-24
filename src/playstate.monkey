Strict

Import flixel

Import codeeditor
Import layout
Import display
Import console

Class PlayState Extends FlxState

	Const TILE_SIZE:Int = 36
	
	Const FIELD_SIZE:Int = 11

	Field codeEditor:CodeEditor

	Method Create:Void()
		FlxG.Camera.X = 26
		FlxG.Camera.Y = 42
		FlxG.Camera.Width = TILE_SIZE * FIELD_SIZE
		FlxG.Camera.Height = FlxG.Camera.Width
		
		Add(New Display(FlxG.Camera))

		Local consoleCamera:FlxCamera = New FlxCamera(454, 111, 171, 260)
		FlxG.AddCamera(consoleCamera)
		
		Add(New Console(consoleCamera))
		
		Local layoutCamera:FlxCamera = New FlxCamera(0, 0, FlxG.Width, FlxG.Height)
		FlxG.AddCamera(layoutCamera)
		
		Add(New Layout(layoutCamera))
	End Method
	
	Method Update:Void()	
		Super.Update()
	End Method

End Class
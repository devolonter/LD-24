Strict

Import flixel

Import codeeditor
Import layout
Import display

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

		'Local consoleCamera:FlxCamera = New FlxCamera(0, FlxG.Camera.Height, FlxG.Width, FlxG.Height - FlxG.Camera.Height)
		'Local toolboxCamera:FlxCamera = New FlxCamera(FlxG.Camera.Width, 0, FlxG.Width - FlxG.Camera.Width, FlxG.Height - consoleCamera.Height)
		
		'FlxG.AddCamera(consoleCamera)
		'FlxG.AddCamera(toolboxCamera)
		
		Local layoutCamera:FlxCamera = New FlxCamera(0, 0, FlxG.Width, FlxG.Height)
		FlxG.AddCamera(layoutCamera)
		
		Add(New Layout(layoutCamera))
		FlxG.Camera.BgColor = $FF12231e
	End Method
	
	Method Update:Void()	
		Super.Update()
	End Method

End Class
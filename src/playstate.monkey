Strict

Import flixel

Import codeeditor
Import layout
Import display
Import console

Class PlayState Extends FlxState

	Const TILE_SIZE:Int = 36
	
	Const FIELD_SIZE:Int = 11	
	
	Field display:Display
	
	Field console:Console
	
	Field layout:Layout

	Method Create:Void()
		FlxG.Camera.X = 26
		FlxG.Camera.Y = 42
		FlxG.Camera.Width = TILE_SIZE * FIELD_SIZE
		FlxG.Camera.Height = FlxG.Camera.Width
		
		display = Display(Add(New Display(Self, FlxG.Camera)))

		Local consoleCamera:FlxCamera = New FlxCamera(454, 111, 171, 260)
		FlxG.AddCamera(consoleCamera)
		
		console = Console(Add(New Console(consoleCamera)))
		
		console.Push("--CONSOLE OUTPUT--")
		
		Local layoutCamera:FlxCamera = New FlxCamera(0, 0, FlxG.Width, FlxG.Height)
		FlxG.AddCamera(layoutCamera)
		
		layout = Layout(Add(New Layout(layoutCamera, display)))
	End Method
	
	Method Update:Void()
		If (layout.runButton.On And Not layout.displayButton.On) Then
			layout.displayButton.Checked = True
		End If
		
		Super.Update()
	End Method

End Class
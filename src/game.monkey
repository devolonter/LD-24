Strict

Import flixel
Import flixel.flxtext.driver.fontmachine

Import menustate
Import playstate
Import inputmanager

Class Game Extends FlxGame

Private
	Field _inputManager:InputManager
	
	Method New()
		Super.New(640, 480, GetClass("PlayState"),,, 60, True)
		_inputManager = InputManager.GetInstance()
	End Method
	
	Method OnContentInit:Void()
		FlxTextFontMachineDriver.Init()
		FlxText.SetDefaultDriver(GetClass("FlxTextFontMachineDriver"))
	End Method
	
	Method OnUpdate:Int()
		_inputManager.Update()
		Return Super.OnUpdate()
	End Method

End Class
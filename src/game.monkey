Strict

Import flixel
Import flixel.flxtext.driver.fontmachine

Import menustate
Import playstate
Import inputmanager
Import assets

Class Game Extends FlxGame

Private
	Field _inputManager:InputManager
	
	Method New()
		Super.New(480, 480, GetClass("PlayState"),,, 60, True)
		_inputManager = InputManager.GetInstance()
	End Method
	
	Method OnContentInit:Void()
		FlxTextFontMachineDriver.Init()
		FlxText.SetDefaultDriver(GetClass("FlxTextFontMachineDriver"))
		
		Local proFont:FlxFont = FlxAssetsManager.AddFont(Assets.FONT_PROFONT, FlxText.DRIVER_FONTMACHINE)
		proFont.SetPath(18, "fonts/profont_" + 18 + ".txt")
	End Method
	
	Method OnUpdate:Int()
		_inputManager.Update()
		Return Super.OnUpdate()
	End Method

End Class
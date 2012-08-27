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
		Super.New(640, 480, GetClass("PlayState"),,, 60, True)
		_inputManager = InputManager.GetInstance()
	End Method
	
	Method OnContentInit:Void()
		FlxTextFontMachineDriver.Init()
		FlxText.SetDefaultDriver(GetClass("FlxTextFontMachineDriver"))
		
		Local proFont:FlxFont = FlxAssetsManager.AddFont(Assets.FONT_PROFONT, FlxText.DRIVER_FONTMACHINE)
		proFont.SetPath(18, "fonts/profont_" + 18 + ".txt")
		
		Local lektonFont:FlxFont = FlxAssetsManager.AddFont(Assets.FONT_LEKTON, FlxText.DRIVER_FONTMACHINE)
		lektonFont.SetPath(12, "fonts/lekton_" + 12 + ".txt")
		
		FlxAssetsManager.AddImage(Assets.SPRITE_LAYOUT, "images/layout.png")
		FlxAssetsManager.AddImage(Assets.SPRITE_DISPLAY_MAIN, "images/display/main.png")
		FlxAssetsManager.AddImage(Assets.SPRITE_DISPLAY_CONSOLE, "images/display/console.png")
		
		FlxAssetsManager.AddImage(Assets.BUTTON_CMD, "images/buttons/cmd.png")
		FlxAssetsManager.AddImage(Assets.BUTTON_RTFM, "images/buttons/rtfm.png")
		FlxAssetsManager.AddImage(Assets.BUTTON_DISPLAY, "images/buttons/display.png")
		FlxAssetsManager.AddImage(Assets.BUTTON_RUN, "images/buttons/start.png")
		FlxAssetsManager.AddImage(Assets.BUTTON_REVERT, "images/buttons/restart.png")
	End Method
	
	Method OnUpdate:Int()
		_inputManager.Update()
		Return Super.OnUpdate()
	End Method

End Class
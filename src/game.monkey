Strict

Import flixel
Import flixel.flxtext.driver.fontmachine

Import menustate
Import playstate
Import inputmanager
Import assets

Class Game Extends FlxGame

	Const LEVELS_COUNT:Int = 12
	
	Const CHIPS_COUNT:Int = 6

Private
	Field _inputManager:InputManager
	
Public
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
		
		FlxAssetsManager.AddImage(Assets.SPRITE_PLAYER, "images/player.png")
		FlxAssetsManager.AddImage(Assets.SPRITE_CHIP, "images/chip.png")
		FlxAssetsManager.AddImage(Assets.SPRITE_BOX, "images/box.png")
		FlxAssetsManager.AddImage(Assets.SPRITE_BUTTON, "images/push_b.png")
		FlxAssetsManager.AddImage(Assets.SPRITE_INTRO, "images/intro.png")
		
		FlxAssetsManager.AddImage(Assets.TILESET, "images/tileset.png")
		
		FlxAssetsManager.AddImage(Assets.BUTTON_CMD, "images/buttons/cmd.png")
		FlxAssetsManager.AddImage(Assets.BUTTON_RTFM, "images/buttons/rtfm.png")
		FlxAssetsManager.AddImage(Assets.BUTTON_DISPLAY, "images/buttons/display.png")
		FlxAssetsManager.AddImage(Assets.BUTTON_RUN, "images/buttons/start.png")
		FlxAssetsManager.AddImage(Assets.BUTTON_REVERT, "images/buttons/restart.png")
		
		For Local i:Int = 1 To LEVELS_COUNT
			FlxAssetsManager.AddString("level_" + i, "levels/" + i + "/map.csv")
			FlxAssetsManager.AddString("console_" + i, "levels/" + i + "/console.log")
		Next
		
		For Local i:Int = 1 To CHIPS_COUNT
			FlxAssetsManager.AddImage("help_" + i, "images/instructions/" + i + ".png")
		Next
		
		FlxAssetsManager.AddSound(Assets.SOUND_KEY, "sounds/key." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(Assets.SOUND_MOVE, "sounds/move." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(Assets.SOUND_LASER_ON, "sounds/laser_on." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(Assets.SOUND_LASER_OFF, "sounds/laser_off." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(Assets.SOUND_HIT, "sounds/hit." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(Assets.SOUND_MODULE, "sounds/module." + FlxSound.GetValidExt())
		
		FlxAssetsManager.AddMusic(Assets.MUSIC_CODENAME_E, "music/codename_e." + FlxMusic.GetValidExt())
	End Method
	
	Method OnUpdate:Int()
		_inputManager.Update()
		Return Super.OnUpdate()
	End Method

End Class
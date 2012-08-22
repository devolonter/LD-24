Strict

Import flixel
Import flixel.flxtext.driver.fontmachine

Import menustate

Class Game Extends FlxGame
	
	Method New()
		Super.New(640, 480, GetClass("MenuState"),,, 60, True)
	End Method
	
	Method OnContentInit:Void()
		FlxTextFontMachineDriver.Init()
		FlxText.SetDefaultDriver(GetClass("FlxTextFontMachineDriver"))
	End Method

End Class
Strict

Import flixel
Import assets

Class Console Extends FlxGroup

	Field width:Float
	
	Field height:Float
	
	Method New(camera:FlxCamera)
		Cameras =[camera.ID]
		width = camera.Width
		height = camera.Height
		
		Add(New FlxSprite(0, 0, Assets.SPRITE_DISPLAY_CONSOLE))
	End Method

End Class
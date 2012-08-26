Strict

Import flixel
Import assets

Class Layout Extends FlxGroup

	Method New(camera:FlxCamera)
		Add(New FlxSprite(0, 0, Assets.SPRITE_LAYOUT))
		Cameras =[camera.ID]
	End Method

End Class
Strict

Import flixel

Import assets

Class LevelMap Extends FlxGroup

	Field width:Float
	
	Field height:Float
	
Public
	Method New(camera:FlxCamera)
		Cameras =[camera.ID]
		width = camera.Width
		height = camera.Height
	End Method

End Class
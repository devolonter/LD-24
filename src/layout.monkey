Strict

Import flixel
Import assets
Import buttons

Class Layout Extends FlxGroup

	Method New(camera:FlxCamera)
		Cameras =[camera.ID]
		Add(New FlxSprite(0, 0, Assets.SPRITE_LAYOUT))
		
		Local toolbarButtons:FlxGroup = New FlxGroup(3)
		Local actionButtons:FlxGroup = New FlxGroup(2)
		
		toolbarButtons.Add(New CmdButton(453, 33, toolbarButtons))
		toolbarButtons.Add(New RtfmButton(513, 33, toolbarButtons))
		Button(toolbarButtons.Add(New DisplayButton(573, 33, toolbarButtons))).Checked = True
		
		actionButtons.Add(New RunButton(453, 399, actionButtons))
		actionButtons.Add(New RevertButton(575, 399, actionButtons))
		
		Add(toolbarButtons)
		Add(actionButtons)
	End Method

End Class
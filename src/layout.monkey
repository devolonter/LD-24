Strict

Import flixel
Import assets
Import buttons
Import display

Class Layout Extends FlxGroup

	Field displayButton:Button
	
	Field runButton:Button

	Method New(camera:FlxCamera, display:Display)
		Cameras =[camera.ID]
		Add(New FlxSprite(0, 0, Assets.SPRITE_LAYOUT))
		
		Local toolbarButtons:FlxGroup = New FlxGroup(3)
		Local actionButtons:FlxGroup = New FlxGroup(2)
		
		toolbarButtons.Add(New CmdButton(453, 33, display, toolbarButtons))
		toolbarButtons.Add(New RtfmButton(513, 33, display, toolbarButtons))
		displayButton = Button(toolbarButtons.Add(New DisplayButton(573, 33, display, toolbarButtons)))		
		
		runButton = Button(actionButtons.Add(New RunButton(453, 399, display, actionButtons)))
		actionButtons.Add(New RevertButton(575, 399, display, actionButtons))
		
		Add(toolbarButtons)
		Add(actionButtons)
	End Method

End Class
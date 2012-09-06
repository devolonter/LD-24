Strict

Import flixel
Import assets
Import display

Class Button Extends FlxButton Implements FlxButtonClickListener Abstract

	Field group:FlxGroup
	
	Field context:Display

	Method New(x:Float = 0, y:Float = 0, context:Display, group:FlxGroup)
		Super.New(x, y, "", Self)
		Self.group = group
		Self.context = context
	End Method
	
	Method Checked:Void(value:Bool) Property
		If (context.IsIntro) Return
	
		If (value And Not On) Then
			OnButtonClick()
		ElseIf( Not value And On)
			On = False
			OnTurnOff()
		End If
	End Method
	
	Method Update:Void()
		Super.Update()
		If (On) Frame = PRESSED
		If (context.IsIntro) Frame = NORMAL
	End Method
	
	Method OnButtonClick:Void()
		If (context.IsIntro) Return
	
		If (group <> Null)
			Local b:Button
		
			For Local bsc:FlxBasic = EachIn group
				b = Button(bsc)
				
				If (b.On And b <> Self) Then
					b.On = False
					b.OnTurnOff()
				 End If
			Next
		
			If ( Not On) Then
				OnTurnOn()
				On = True	
			End If
		Else
			OnTurnOn()
		End if
	End Method
	
	Method OnTurnOn:Void() Abstract
	
	Method OnTurnOff:Void() Abstract

End Class

Class CmdButton Extends Button

	Method New(x:Float = 0, y:Float = 0, context:Display, group:FlxGroup)
		Super.New(x, y, context, group)
		LoadGraphic(Assets.BUTTON_CMD, True, False, 48, 48)
	End Method
	
	Method OnTurnOn:Void()
		context.TurnOn(Display.CMD_WINDOW)
	End Method
	
	Method OnTurnOff:Void()
		context.TurnOff(Display.CMD_WINDOW)
	End Method
	
End Class

Class RtfmButton Extends Button

	Method New(x:Float = 0, y:Float = 0, context:Display, group:FlxGroup)
		Super.New(x, y, context, group)
		LoadGraphic(Assets.BUTTON_RTFM, True, False, 48, 48)
	End Method
	
	Method OnTurnOn:Void()
		context.TurnOn(Display.HELP_WINDOW)
	End Method
	
	Method OnTurnOff:Void()
		context.TurnOff(Display.HELP_WINDOW)
	End Method
	
End Class

Class DisplayButton Extends Button

	Method New(x:Float = 0, y:Float = 0, context:Display, group:FlxGroup)
		Super.New(x, y, context, group)
		LoadGraphic(Assets.BUTTON_DISPLAY, True, False, 48, 48)
	End Method
	
	Method OnTurnOn:Void()
		context.TurnOn(Display.MAP_WINDOW)
	End Method
	
	Method OnTurnOff:Void()
		context.TurnOff(Display.MAP_WINDOW)
	End Method
	
End Class

Class RunButton Extends Button

	Method New(x:Float = 0, y:Float = 0, context:Display, group:FlxGroup)
		Super.New(x, y, context, group)
		LoadGraphic(Assets.BUTTON_RUN, True, False, 109, 48)
	End Method
	
	Method OnTurnOn:Void()		
		context.Exec()
	End Method
	
	Method OnTurnOff:Void()		
	End Method
	
End Class

Class RevertButton Extends Button

	Method New(x:Float = 0, y:Float = 0, context:Display, group:FlxGroup)
		Super.New(x, y, context, group)
		LoadGraphic(Assets.BUTTON_REVERT, True, False, 48, 48)
	End Method
	
	Method OnButtonClick:Void()
		Super.OnButtonClick()
		On = False
	End Method
	
	Method OnTurnOn:Void()
		context.levelMap.ReloadLevel()
	End Method
	
	Method OnTurnOff:Void()
		
	End Method
	
End Class


Strict

Import flixel
Import assets

Class Button Extends FlxButton Implements FlxButtonClickListener Abstract

	Field group:FlxGroup

	Method New(x:Float = 0, y:Float = 0, group:FlxGroup)
		Super.New(x, y, "", Self)
		Self.group = group
	End Method
	
	Method Checked:Void(value:Bool) Property
		If (value And Not On) Then
			OnButtonClick()
		ElseIf( Not value And On)
			OnButtonClick()
		End If
	End Method
	
	Method Update:Void()
		Super.Update()
		If (On) Frame = PRESSED
	End Method
	
	Method OnButtonClick:Void()
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

	Method New(x:Float = 0, y:Float = 0, group:FlxGroup)
		Super.New(x, y, group)
		LoadGraphic(Assets.BUTTON_CMD, True, False, 48, 48)
	End Method
	
	Method OnTurnOn:Void()
	End Method
	
	Method OnTurnOff:Void()
	End Method
	
End Class

Class RtfmButton Extends Button

	Method New(x:Float = 0, y:Float = 0, group:FlxGroup)
		Super.New(x, y, group)
		LoadGraphic(Assets.BUTTON_RTFM, True, False, 48, 48)
	End Method
	
	Method OnTurnOn:Void()
		
	End Method
	
	Method OnTurnOff:Void()
		
	End Method
	
End Class

Class DisplayButton Extends Button

	Method New(x:Float = 0, y:Float = 0, group:FlxGroup)
		Super.New(x, y, group)
		LoadGraphic(Assets.BUTTON_DISPLAY, True, False, 48, 48)
	End Method
	
	Method OnTurnOn:Void()
		
	End Method
	
	Method OnTurnOff:Void()
		
	End Method
	
End Class

Class RunButton Extends Button

	Method New(x:Float = 0, y:Float = 0, group:FlxGroup)
		Super.New(x, y, group)
		LoadGraphic(Assets.BUTTON_RUN, True, False, 109, 48)
	End Method
	
	Method OnTurnOn:Void()
		
	End Method
	
	Method OnTurnOff:Void()
		
	End Method
	
End Class

Class RevertButton Extends Button

	Method New(x:Float = 0, y:Float = 0, group:FlxGroup)
		Super.New(x, y, group)
		LoadGraphic(Assets.BUTTON_REVERT, True, False, 48, 48)
	End Method
	
	Method OnButtonClick:Void()
		Super.OnButtonClick()
		On = False
	End Method
	
	Method OnTurnOn:Void()
		
	End Method
	
	Method OnTurnOff:Void()
		
	End Method
	
End Class


Strict

Import flixel
Import assets

Class Console Extends FlxGroup

	Field width:Float
	
	Field height:Float
	
Private
	Const _MAX_MESSAGES_COUNT:Int = 11
	
	Global _Console:Console

	Field _text:FlxText
	
	Field _textStack:StringStack
	
Public
	Method New(camera:FlxCamera)
		If (_Console <> Null) Then
			Error "Console must be singleton"
		End If
	
		Cameras =[camera.ID]
		width = camera.Width
		height = camera.Height
		
		Add(New FlxSprite(0, 0, Assets.SPRITE_DISPLAY_CONSOLE))
		
		_text = New FlxText(10, 10, width - 20, "")
		_text.SetFormat(Assets.FONT_LEKTON, 12)
		
		Add(_text)
		
		_textStack = New StringStack()
		
		_Console = Self
	End Method
	
	Method Push:Void(message:String)
		If (_textStack.Length() = _MAX_MESSAGES_COUNT) Then
			_textStack.Remove(0)
		End If
	
		_textStack.Push(message)
		
		_text.Text = _textStack.Join("~n")
	End Method
	
	Function GetInstance:Console()
		Return _Console
	End Function
	
End Class
Strict

Import flixel
Import assets

Class Console Extends FlxGroup

	Field width:Float
	
	Field height:Float
	
Private
	Const _MAX_MESSAGES_COUNT:Int = 11
	
	Global _Console:Console

	Field _text:FlxText[_MAX_MESSAGES_COUNT]
	
	Field _mark:Int = 1
	
Public
	Method New(camera:FlxCamera)
		If (_Console <> Null) Then
			Error "Console must be singleton"
		End If
	
		Cameras =[camera.ID]
		width = camera.Width
		height = camera.Height
		
		Add(New FlxSprite(0, 0, Assets.SPRITE_DISPLAY_CONSOLE))
		
		For Local i:Int = 0 Until _MAX_MESSAGES_COUNT
			_text[i] = New FlxText(10, 10 + i * 21, width - 20, "")
			_text[i].SetFormat(Assets.FONT_LEKTON, 12)
			Add(_text[i])
		Next
		
		_text[0].Alignment = FlxText.ALIGN_CENTER
		
		_Console = Self
	End Method
	
	Method Title:Void(message:String)
		_text[0].Text = "--" + message.ToUpper() + "--"
	End Method
	
	Method Push:Void(message:String)
		If (_mark >= _MAX_MESSAGES_COUNT) Then
			For Local i:Int = 2 Until _MAX_MESSAGES_COUNT
				_text[i - 1].Text = _text[i].Text
			Next
		End If
		
		_mark = Min(_mark, _MAX_MESSAGES_COUNT - 1)
		_text[_mark].Text = message
		_mark += 1
	End Method
	
	Method Empty:Void()
		For Local i:Int = 1 Until _MAX_MESSAGES_COUNT
			_text[i].Text = ""
		Next
		
		_mark = 1
	End Method
	
	Function GetInstance:Console()
		Return _Console
	End Function
	
End Class
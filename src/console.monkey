Strict

Import flixel
Import assets

Class Console Extends FlxGroup

	Field width:Float
	
	Field height:Float
	
Private
	Const _MAX_MESSAGES_COUNT:Int = 11

	Field _text:FlxText
	
	Field _textStack:StringStack
	
	Method New(camera:FlxCamera)
		Cameras =[camera.ID]
		width = camera.Width
		height = camera.Height
		
		Add(New FlxSprite(0, 0, Assets.SPRITE_DISPLAY_CONSOLE))
		
		_text = New FlxText(10, 10, width - 20, "")
		_text.SetFormat(Assets.FONT_LEKTON, 12)
		
		Add(_text)
		
		_textStack = New StringStack()
	End Method
	
	Method Push:Void(message:String)
		If (_textStack.Length() = _MAX_MESSAGES_COUNT) Then
			_textStack.Remove(0)
		End If
	
		_textStack.Push(message)
		
		_text.Text = _textStack.Join("~n")
	End Method
	
End Class
Strict

Import fontmachine
Import flixel

Import assets
Import inputmanager
Import caret

Class CodeEditor Extends FlxGroup

	Field x:Float
	
	Field y:Float
	
	Field width:Float
	
	Field height:Float
	
Private
	Const _LINE_HEIGHT:Int = 25
	
	Const _MEMORY_LIMIT:Int = 15
	
	Field _cmd:FlxText[_MEMORY_LIMIT]
	
	Field _caret:Caret
	
	Field _mark:Int
	
	Field _charWidth:Int
	
	Field _charHeight:Int

	Field _inputManager:InputManager
	
Public	
	Method New(x:Float, y:Float, width:Float, height:Float)
		Self.x = x
		Self.y = y
		Self.width = width
		Self.height = height
		
		#Rem
		Local title:FlxText = New FlxText(x + 10, y + 10, width - 20, "MICRO EVO IDE V24 LD:")
		title.SetFormat(Assets.FONT_PROFONT, 18)
		Add(title)
		#End
		
		For Local i:Int = 0 Until _MEMORY_LIMIT
			_cmd[i] = New FlxText(x, y + i * _LINE_HEIGHT, width, "")
			_cmd[i].SetFormat(Assets.FONT_PROFONT, 18)
			Add(_cmd[i])
		Next
		
		_charWidth = BitmapFont(_cmd[0].GetFontObject()).GetTxtWidth("0") * 0.6
		_charHeight = BitmapFont(_cmd[0].GetFontObject()).GetTxtHeight("0") * 0.5
		_mark = 0
		
		_inputManager = InputManager.GetInstance()
		
		_caret = New Caret(x, y, _charWidth, _charHeight)
		Add(_caret)
	End Method
	
	Method Update:Void()
		Super.Update()
		
		If (_inputManager.GetChar() > 32) Then
			_cmd[_mark].Text += String.FromChar(_inputManager.GetChar()).ToUpper()
			
			If (_cmd[_mark].Text.Length() = 3) Then
				_mark = Min(_MEMORY_LIMIT - 1, _mark + 1)
				_caret.x = x
				_caret.y = y + _mark * _LINE_HEIGHT
			Else
				_caret.x += _charWidth
			End If
			
		Else
			If (_inputManager.GetChar() = CHAR_BACKSPACE) Then
				If (_cmd[_mark].Text.Length() = 0) Then
					_mark = Max(0, _mark - 1)
					_caret.x = (_cmd[_mark].Text.Length() +2) * _charWidth
					_caret.y = y + _mark * _LINE_HEIGHT
				Else
					_cmd[_mark].Text = _cmd[_mark].Text[0 .. _cmd[_mark].Text.Length() -1]
					_caret.x -= _charWidth
				End If
			
				
			End If
		End If
	End Method
	
	Method GetSource:String()
		Local source:StringStack = New StringStack()
	
		For Local i:Int = 0 Until _MEMORY_LIMIT
			source.Push(_cmd[i].Text)
		Next
		
		Return source.Join(";")
	End Method

End Class
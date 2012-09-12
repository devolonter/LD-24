Strict

Import fontmachine
Import flixel

Import assets
Import inputmanager
Import caret
Import modules
Import levelmap

Class CodeEditor Extends FlxGroup

	Field x:Float
	
	Field y:Float
	
	Field width:Float
	
	Field height:Float
	
Private
	Const _LINE_HEIGHT:Int = 25
	
	Const _MEMORY_LIMIT:Int = 15
	
	Field _availableChars:StringSet
	
	Field _availableCommands:StringSet
	
	Field _cmd:FlxText[_MEMORY_LIMIT]
	
	Field _caret:Caret
	
	Field _mark:Int
	
	Field _charWidth:Int
	
	Field _charHeight:Int

	Field _inputManager:InputManager
	
	Field _console:Console
	
	Field _memoryLimit:Int
	
Public	
	Method New(x:Float, y:Float, width:Float, height:Float)
		Self.x = x
		Self.y = y
		Self.width = width
		Self.height = height
		
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
		
		_memoryLimit = _MEMORY_LIMIT
		
		Reset()
	End Method
	
	Method Reset:Void()
		_availableCommands = New StringSet()
		_availableChars = New StringSet()
		
		For Local i:Int = 1 To 9
			_availableChars.Insert(i)
		Next
	End Method
	
	Method Update:Void()
		Super.Update()
				
		If ( Not visible) Return
		If (_console = Null) _console = Console.GetInstance()
		
		If (_inputManager.GetChar() > 32) Then
			If (_mark = _memoryLimit) Then
				_console.Push("Memory limit")
				Return
			End If
		
			Local chr:String = String.FromChar(_inputManager.GetChar()).ToUpper()
			Local l:Int = _cmd[_mark].Text.Length()
		
			If ( Not _availableChars.Contains(chr)) Then
				_console.Push("Symbol " + chr + " is incorrect")
				Return
			End If
			
			If (l = 1) Then
				If ( Not _availableCommands.Contains(_cmd[_mark].Text + chr)) Then
					_console.Push("Unknown command " + (_cmd[_mark].Text + chr))
					Return
				End If
			End If
			
			If (l = 2) Then
				If (_inputManager.GetChar() < 49 Or _inputManager.GetChar() > 57) Then
					_console.Push("X must be numeric")
					Return
				End If
			End If
			
			FlxG.Play(Assets.SOUND_KEY, 0.5)
		
			_cmd[_mark].Text += chr
			l += 1
			
			If (l >= 3) Then
				If (l > 3) Then
					_cmd[_mark].Text = _cmd[_mark].Text[0 .. 3]
				End If
			
				_mark = _mark + 1
				
				If (_mark = _memoryLimit) Then
					_caret.visible = False
					Return
				End if
				
				_caret.x = x
				_caret.y = y + _mark * _LINE_HEIGHT
			Else
				_caret.x += _charWidth
			End If
			
		Else
			If (_inputManager.GetChar() = CHAR_BACKSPACE) Then
				FlxG.Play(Assets.SOUND_KEY, .5)
			
				If (_mark = _MEMORY_LIMIT) Then
					_caret.visible = True
					_caret.x += _charWidth
					_mark -= 1
				End if
			
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
	
	Method AddModule:Void(robotModule:RobotModule)
		For Local chr:Int = EachIn robotModule.name
			_availableChars.Insert(String.FromChar(chr))
		Next
		
		_availableCommands.Insert(robotModule.name)
	End Method
	
	Method GetSource:String()
		Local source:StringStack = New StringStack()
	
		For Local i:Int = 0 Until _MEMORY_LIMIT
			If(_cmd[i].Text.Length() > 0) source.Push(_cmd[i].Text)
		Next
		
		Return source.Join(";")
	End Method
	
	Method MemoryLimit:Void(limit:Int) Property
		_memoryLimit = Min(limit, _MEMORY_LIMIT)
	End Method
	
	Method Empty:Void()
		For Local i:Int = 0 Until _MEMORY_LIMIT
			_cmd[i].Text = ""			
		Next
		
		_mark = 0
		_caret.Reset(_cmd[0].x, _cmd[0].y)
	End Method

End Class
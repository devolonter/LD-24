Strict

Import fontmachine
Import flixel

Import assets
Import inputmanager

Class CodeEditor Extends FlxGroup

	Field x:Float
	
	Field y:Float
	
	Field width:Float
	
	Field height:Float
	
Private
	Const _LINE_HEIGHT:Int = 25
	
	Const _MEMORY_LIMIT:Int = 15
	
	Field _cmd:FlxText[_MEMORY_LIMIT]
	
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
		
		_charWidth = BitmapFont(_cmd[0].GetFontObject()).GetTxtWidth("0")
		_charHeight = BitmapFont(_cmd[0].GetFontObject()).GetTxtHeight("0")
		_mark = 0
		
		_inputManager = InputManager.GetInstance()
	End Method
	
	

End Class
Strict

Import flixel
Import game

Class Help Extends FlxGroup

	Field listener:ModuleAddListener

Private
	Field _instructions:FlxSprite[Game.CHIPS_COUNT]
	
	Field _moduleNames:String[] =["", "", "", "PUSH", "PULL", "ROTATE"]
	
	Field _mark:Int = 3
	
Public
	Method New(x:Int, y:Int)
	
		Local col:Int = 0
		Local row:Int = 0
		
		_mark = 3
		
		For Local i:Int = 0 Until Game.CHIPS_COUNT
			col = i Mod 2
			If (col = 0 And i > 0) row += 1
		
			_instructions[i] = New FlxSprite(0, 0, "help_" + (i + 1))
			_instructions[i].Reset(x + _instructions[i].width * col + 65 * col, y + _instructions[i].height * row + 12 * row)
			
			If (i >= _mark) _instructions[i].visible = False
			
			Add(_instructions[i])
		Next
	End Method
	
	Method OpenNextModule:Void()
		_instructions[_mark].visible = True
		
		If (_moduleNames[_mark].Length() > 0) Then
			listener.OnModuleAdded(_mark)
		End If
		
		_mark += 1
	End Method
	
	Method NextModuleInfo:Void()
		If (_moduleNames[_mark].Length() > 0) Then
			Console.GetInstance().Push("Module " + _moduleNames[_mark] + " was added")
			Console.GetInstance().Push("see RTFM")
		End If
	End Method
	
	Method Reset:Void()
		For Local i:Int = 3 Until Game.CHIPS_COUNT
			_instructions[i].visible = False
		Next
		
		_mark = 3
	End Method

End Class

Interface ModuleAddListener
	
	Method OnModuleAdded:Void(m:Int)

End Interface
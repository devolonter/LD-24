Strict

Import flixel
Import game

Class Help Extends FlxGroup

Private
	Field _instructions:FlxSprite[Game.CHIPS_COUNT]
	
	Field _moduleNames:String[] =["", "", "", "PUSH", "PULL", "ROTATE"]
	
	Field _mark:Int = 3

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
			Console.GetInstance().Push("Module " + _moduleNames[_mark] + " was added! See manual")
		End If
		
		_mark += 1
	End Method

End Class
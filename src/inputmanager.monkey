Strict

Import mojo

Alias mojoGetChar = mojo.input.GetChar

Class InputManager
	
Private
	Global _instance:InputManager
	
	Field _char:Int
	
Public
	Function GetInstance:InputManager()
		If (_instance = Null) _instance = New InputManager()
		Return _instance
	End Function
	
	Method Update:Void()
		_char = mojoGetChar()
	End Method
	
	Method GetChar:Int()
		Return _char
	End Method

End Class
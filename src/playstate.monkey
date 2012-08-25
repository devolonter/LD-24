Strict

Import flixel

Import inputmanager

Class PlayState Extends FlxState

Private
	Field _inputManager:InputManager
	
	Method Create:Void()
		_inputManager = InputManager.GetInstance()
	End Method
	
	Method Update:Void()
		Local char:= _inputManager.GetChar()
        If char >= 32
            Print String.FromChar(char)
        Endif
	
		Super.Update()
	End Method

End Class
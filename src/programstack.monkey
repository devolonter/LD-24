Strict

Import flixel
Import player
Import modules

Class ProgramStack Extends FlxBasic Implements FlxTweenListener

Private
	Field _commands:String[]
	
	Field _mark:Int
	
	Field _complete:Bool
	
	Field _hasError:Bool

	Field _modules:StringMap<RobotModule>
	
	Field _context:Player
	
	Field _reason:String
	
Public
	Method New(context:Player)
		_context = context
		Reset()
	End Method
	
	Method Reset:Void()
		_modules = New StringMap<RobotModule>
		_mark = 0
		_complete = False
		_hasError = False
		visible = False
		active = False
	End Method
	
	Method AddModule:Void(robotModule:RobotModule)
		robotModule.SetContext(Self)
		_modules.Set(robotModule.name, robotModule)
	End Method
	
	Method Exec:Void(program:String)
		_complete = False
		_hasError = False
		_reason = ""
		active = True
		
		_commands = program.Split(";")
		Console.GetInstance().Empty()
		
		If ( Not ExecNext()) Then
			_complete = True
			_hasError = True
			If (program = "") Then
				_reason = "Target was not reached"
			End If
		End If
	End Method
	
	Method OnTweenComplete:Void()
		_mark += 1
		
		If (_commands.Length() = _mark) Then
			_complete = True
			_mark = 0
			Return
		End If
		
		If ( Not ExecNext()) Then
			_complete = True
			_hasError = True
		End If
	End Method
	
	Method ExecNext:Bool()
		If (_complete) Then
			Return False
		End If
		
		If (_commands[_mark].Length() <> 3) Then
			_reason = "Unknown command: " + _commands[_mark].Length()
			Return False
		End If
	
		Local cmd:String = _commands[_mark][0 .. 2]
		Local execMod:RobotModule = _modules.Get(cmd)
		
		Console.GetInstance().Push("Exec " + _commands[_mark] + "...")
		
		If (execMod = Null) Then
			_reason = "Unknown command: " + cmd
			Return False
		End If
		
		Return execMod.Exec(Int(_commands[_mark][2 .. 3]))
	End Method
	
	Method Stop:Void(reason:String = "")
		If (HasTween()) ClearTweens()
		_complete = True
		If (reason.Length() <> 0) Then
			_hasError = True
			_reason = reason
		End If
		_mark = 0
		active = False
	End Method
	
	Method Clear:Void()
		Stop()
		_complete = False
		_hasError = False
	End Method
	
	Method IsComplete:Bool()
		Return _complete
	End Method
	
	Method HasError:Bool()
		Return _hasError
	End Method
	
	Method Context:Player() Property
		Return _context
	End Method
	
	Method Reason:String() Property
		Return _reason
	End Method

End Class
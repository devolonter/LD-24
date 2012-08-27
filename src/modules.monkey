Strict

Import flixel
Import programstack
Import player
Import console

Class RobotModule Abstract

	Field name:String

Private
	Field _programStack:ProgramStack
	
	Field _tween:FlxTween
	
Public
	Method Exec:Bool(value:Int) Abstract
	
	Method SetContext:Void(stack:ProgramStack)
		_programStack = stack
	End Method

End Class

Class MfModule Extends RobotModule
	
	Method New()
		name = "MF"
	End Method
	
	Method SetContext:Void(stack:ProgramStack)
		Super.SetContext(stack)
		_tween = New LinearMotion(_programStack)
		LinearMotion(_tween).SetObject(_programStack.Context)
		_programStack.AddTween(_tween)
		_programStack.Context.immovable = False
	End Method
	
	Method Exec:Bool(value:Int)
		If ( Not _programStack.Context) Return False
	
		Local p:Player = _programStack.Context
		
		Select p.angle
			Case 0
				LinearMotion(_tween).SetMotionSpeed(p.x, p.y, p.x, 
					p.y -PlayState.TILE_SIZE * value, PlayState.TILE_SIZE * 2, Ease.SineInOut)
			Case 90, -270
				LinearMotion(_tween).SetMotionSpeed(p.x, p.y, p.x + PlayState.TILE_SIZE * value,
					p.y, PlayState.TILE_SIZE * 2, Ease.SineInOut)
			Case 180, -180
				LinearMotion(_tween).SetMotionSpeed(p.x, p.y, p.x,
					p.y +PlayState.TILE_SIZE * value, PlayState.TILE_SIZE * 2, Ease.SineInOut)
			
			Case 270, -90
				LinearMotion(_tween).SetMotionSpeed(p.x, p.y, p.x - PlayState.TILE_SIZE * value,
					p.y, PlayState.TILE_SIZE * 2, Ease.SineInOut)
				
		End Select
		
		Console.GetInstance().Push("Successful!")
		
		Return True
	End Method

End Class

Class MrModule Extends RobotModule Implements FlxTweenListener

Private
	Field mfModule:MfModule
	
	Field value:Int
	
	Method New()
		name = "MR"
		mfModule = New MfModule()
	End Method
	
	Method SetContext:Void(stack:ProgramStack)
		Super.SetContext(stack)
		
		_tween = New VarTween(Self)
		_programStack.AddTween(_tween)
		
		mfModule.SetContext(stack)
	End Method
	
	Method Exec:Bool(value:Int)
		If ( Not _programStack.Context) Return False
		Local p:Player = _programStack.Context
	
		Local angle:Int = p.angle + 90
		If (angle = 360) angle = 0
		
		VarTween(_tween).Tween(p, "angle", angle, 0.5, Ease.SineInOut)
		Self.value = value
		
		Return True
	End Method
	
	Method OnTweenComplete:Void()
		mfModule.Exec(value)
	End Method

End Class

Class MlModule Extends RobotModule Implements FlxTweenListener

Private
	Field mfModule:MfModule
	
	Field value:Int
	
	Method New()
		name = "ML"
		mfModule = New MfModule()
	End Method
	
	Method SetContext:Void(stack:ProgramStack)
		Super.SetContext(stack)
		
		_tween = New VarTween(Self)
		_programStack.AddTween(_tween)
		
		mfModule.SetContext(stack)
	End Method
	
	Method Exec:Bool(value:Int)
		If ( Not _programStack.Context) Return False
		Local p:Player = _programStack.Context
		
		Local angle:Int = p.angle - 90
		If (angle = -360) angle = 0
		
		VarTween(_tween).Tween(p, "angle", angle, 0.5, Ease.SineInOut)
		Self.value = value
		
		Return True
	End Method
	
	Method OnTweenComplete:Void()
		mfModule.Exec(value)
	End Method

End Class
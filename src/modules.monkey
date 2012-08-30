Strict

Import flixel
Import programstack
Import player
Import console
Import box

Class RobotModule Abstract

	Field name:String

Private
	Field _programStack:ProgramStack
	
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
	
	Method Exec:Bool(value:Int)
		If ( Not _programStack.Context) Return False
	
		Local p:Player = _programStack.Context
		
		Local tween:LinearMotion = New LinearMotion(_programStack)
		_programStack.AddTween(tween)
		tween.SetObject(p)
		p.immovable = False
		
		Select p.angle
			Case 0
				tween.SetMotionSpeed(p.x, p.y, p.x,
					p.y -PlayState.TILE_SIZE * value, PlayState.TILE_SIZE * 2, Ease.SineInOut)
			Case 90, -270
				tween.SetMotionSpeed(p.x, p.y, p.x + PlayState.TILE_SIZE * value,
					p.y, PlayState.TILE_SIZE * 2, Ease.SineInOut)
			Case 180, -180
				tween.SetMotionSpeed(p.x, p.y, p.x,
					p.y +PlayState.TILE_SIZE * value, PlayState.TILE_SIZE * 2, Ease.SineInOut)
			
			Case 270, -90
				tween.SetMotionSpeed(p.x, p.y, p.x - PlayState.TILE_SIZE * value,
					p.y, PlayState.TILE_SIZE * 2, Ease.SineInOut)
				
		End Select
		
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
		mfModule.SetContext(stack)
	End Method

	
	Method Exec:Bool(value:Int)
		If ( Not _programStack.Context) Return False
		Local p:Player = _programStack.Context
		
		Local tween:VarTween = New VarTween(Self)
		_programStack.AddTween(tween)
		
		tween.Tween(p, "angle", p.angle + 90, 0.5, Ease.SineInOut)
		p.immovable = False
		Self.value = value
		
		Return True
	End Method
	
	Method OnTweenComplete:Void()
		Local p:Player = _programStack.Context
		p.angle Mod = 360
		
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
		mfModule.SetContext(stack)
	End Method
	
	Method Exec:Bool(value:Int)
		If ( Not _programStack.Context) Return False
		Local p:Player = _programStack.Context
		
		Local tween:VarTween = New VarTween(Self)
		_programStack.AddTween(tween)
		
		tween.Tween(p, "angle", p.angle - 90, 0.5, Ease.SineInOut)
		p.immovable = False
		Self.value = value
		
		Return True
	End Method
	
	Method OnTweenComplete:Void()
		Local p:Player = _programStack.Context
		p.angle Mod = 360
	
		mfModule.Exec(value)
	End Method

End Class

Class PsModule Extends RobotModule Implements FlxTweenListener

Private
	Field _box:Box

Public
	Method New()
		name = "PS"
	End Method
	
	Method Exec:Bool(value:Int)
		If ( Not _programStack.Context) Return False
	
		Local p:Player = _programStack.Context
		Local l:LevelMap = p.Context
		
		_box = l.GetBox()
		If (_box = Null) Return False

		Select p.angle
			Case 0
				_box.tween.SetMotionSpeed(_box.x, _box.y, _box.x,
					_box.y -PlayState.TILE_SIZE * value, PlayState.TILE_SIZE * 2, Ease.QuadOut)

			Case 90, -270
				_box.tween.SetMotionSpeed(_box.x, _box.y, _box.x + PlayState.TILE_SIZE * value,
					_box.y, PlayState.TILE_SIZE * 2, Ease.SineInOut)
			Case 180, -180
				_box.tween.SetMotionSpeed(_box.x, _box.y, _box.x,
					_box.y +PlayState.TILE_SIZE * value, PlayState.TILE_SIZE * 2, Ease.SineInOut)
			
			Case 270, -90
				_box.tween.SetMotionSpeed(_box.x, _box.y, _box.x - PlayState.TILE_SIZE * value,
					_box.y, PlayState.TILE_SIZE * 2, Ease.SineInOut)
				
		End Select

		_box.active = True
		_box.tween.complete = Self
		_box.tween.Start()
		Return True
	End Method
	
	Method OnTweenComplete:Void()
		_box.active = False
		_programStack.OnTweenComplete()
	End Method
	
End Class

Class PlModule Extends RobotModule Implements FlxTweenListener

Private
	Field _box:Box

Public
	Method New()
		name = "PL"
	End Method
	
	Method Exec:Bool(value:Int)
		If ( Not _programStack.Context) Return False
	
		Local p:Player = _programStack.Context
		Local l:LevelMap = p.Context
		
		_box = l.GetBox()
		If (_box = Null) Return False
		
		Local tween:LinearMotion = New LinearMotion(_programStack)
		_programStack.AddTween(tween)
		tween.SetObject(p)
		p.immovable = False

		Select p.angle
			Case 0
				_box.tween.SetMotionSpeed(_box.x, _box.y, _box.x,
					_box.y +PlayState.TILE_SIZE * value, PlayState.TILE_SIZE * 2, Ease.SineInOut)
					
				tween.SetMotionSpeed(p.x, p.y, p.x,
					p.y +PlayState.TILE_SIZE * value, PlayState.TILE_SIZE * 2, Ease.SineInOut)

			Case 90, -270
				_box.tween.SetMotionSpeed(_box.x, _box.y, _box.x - PlayState.TILE_SIZE * value,
					_box.y, PlayState.TILE_SIZE * 2, Ease.SineInOut)
					
				tween.SetMotionSpeed(p.x, p.y, p.x - PlayState.TILE_SIZE * value,
					p.y, PlayState.TILE_SIZE * 2, Ease.SineInOut)
					
			Case 180, -180
				_box.tween.SetMotionSpeed(_box.x, _box.y, _box.x,
					_box.y -PlayState.TILE_SIZE * value, PlayState.TILE_SIZE * 2, Ease.SineInOut)
					
				tween.SetMotionSpeed(p.x, p.y, p.x,
					p.y -PlayState.TILE_SIZE * value, PlayState.TILE_SIZE * 2, Ease.SineInOut)
			
			Case 270, -90
				_box.tween.SetMotionSpeed(_box.x, _box.y, _box.x + PlayState.TILE_SIZE * value,
					_box.y, PlayState.TILE_SIZE * 2, Ease.SineInOut)
					
				tween.SetMotionSpeed(p.x, p.y, p.x + PlayState.TILE_SIZE * value,
					p.y, PlayState.TILE_SIZE * 2, Ease.SineInOut)
				
		End Select
		
		_box.active = True
		_box.tween.complete = Self
		
		_box.tween.Start()
		tween.Start()
		Return True
	End Method
	
	Method OnTweenComplete:Void()
		_box.active = False
		_programStack.OnTweenComplete()
	End Method
	
End Class

Class RtModule Extends RobotModule Implements FlxTweenListener

	Method New()
		name = "RT"
	End Method
	
	Method Exec:Bool(value:Int)
		If ( Not _programStack.Context) Return False
		Local p:Player = _programStack.Context
		
		Local tween:VarTween = New VarTween(Self)
		_programStack.AddTween(tween)
		
		tween.Tween(p, "angle", p.angle + 90 * value, 0.5 * value, Ease.SineInOut)
		
		Return True
	End Method
	
	Method OnTweenComplete:Void()
		Local p:Player = _programStack.Context
		p.angle Mod = 360

		_programStack.OnTweenComplete()
	End Method

End Class
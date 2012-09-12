Strict

Import flixel

Import assets
Import codeeditor
Import levelmap
Import playstate
Import modules
Import help

Class Display Extends FlxGroup Implements FlxTweenListener, ModuleAddListener

	Const CMD_WINDOW:Int = 1
	
	Const HELP_WINDOW:Int = 2
	
	Const MAP_WINDOW:Int = 3

	Field width:Float
	
	Field height:Float
	
	Field codeEditor:CodeEditor
	
	Field levelMap:LevelMap
	
	Field help:Help
	
	Field context:PlayState

Private
	Field _background:FlxSprite

	Field _hertzLine:FlxSprite
	
	Field _camera:FlxCamera
	
	Field _currentLevel:Int
	
	Field _fadeTween:NumTween
	
	Field _fadeTweenListener:FadeInTweenListener
	
	Field _errorOccured:Bool
	
	Field _intro:FlxGroup
	
	Field _introText:FlxText
	
	Field _introSprite:FlxSprite
	
	Field _introTween:NumTween
	
	Field _isIntro:Bool
	
Public
	Method New(context:PlayState, camera:FlxCamera)
		Cameras =[camera.ID]
		width = camera.Width
		height = camera.Height
		
		_camera = camera
		Self.context = context
		
		levelMap = New LevelMap(Self)
		levelMap.visible = False
		levelMap.active = False
		Add(levelMap)
		
		_background = New FlxSprite(0, 0, Assets.SPRITE_DISPLAY_MAIN)
		Add(_background)
		
		_intro = New FlxGroup(2)
		
		_introSprite = New FlxSprite(0, 0)
		_introSprite.LoadGraphic(Assets.SPRITE_INTRO, True,, 157, 136)
		_introSprite.AddAnimation("unbox",[0, 1, 2], 1)
		_introSprite.Reset( (width - _introSprite.width) * 0.5, (height * 0.85 - _introSprite.height) * 0.5)
		_introSprite.Play("unbox")
		_intro.Add(_introSprite)
		
		_introText = New FlxText(0, _introSprite.y + _introSprite.height + 50, width, "PRESS ENTER TO START")
		_introText.SetFormat(Assets.FONT_PROFONT, 18,, FlxText.ALIGN_CENTER)
		_intro.Add(_introText)
		
		_introTween = New NumTween(, FlxTween.PINGPONG)
		_introTween.Tween(1, 0, 1.5, Ease.SineInOut)
		_intro.AddTween(_introTween, True)
		
		Add(_intro)
		
		codeEditor = New CodeEditor(15, 15, width - 30, height)
		codeEditor.visible = False
		Add(codeEditor)
		
		help = New Help(30, 15)
		help.visible = False
		Add(help)
		
		_fadeTweenListener = New FadeInTweenListener(Self)
		_fadeTween = New NumTween()
		AddTween(_fadeTween)
		
		_hertzLine = New FlxSprite(0, camera.Height)
		_hertzLine.MakeGraphic(camera.Width, camera.Height * 0.25)
		_hertzLine.Alpha = 0.05
		
		Local hertzTween:LinearMotion = New LinearMotion(, FlxTween.LOOPING)
		hertzTween.SetMotionSpeed(_hertzLine.x, _hertzLine.y, _hertzLine.x, -_hertzLine.height, 100)
		hertzTween.SetObject(_hertzLine)
				
		_hertzLine.AddTween(hertzTween)
		Add(_hertzLine)
		
		AddTween(New Alarm(6, Self), True)
		help.listener = Self
		_isIntro = True
	End Method
	
	Method Init:Void()
		_currentLevel = 1
		
		Local mfModule:MfModule = New MfModule()
		codeEditor.AddModule(mfModule)
		levelMap.programStack.AddModule(mfModule)
		
		Local mrModule:MrModule = New MrModule()
		codeEditor.AddModule(mrModule)
		levelMap.programStack.AddModule(mrModule)
		
		Local mlModule:MlModule = New MlModule()
		codeEditor.AddModule(mlModule)
		levelMap.programStack.AddModule(mlModule)
		
		levelMap.active = True
		levelMap.LoadLevel(_currentLevel)
	End Method
	
	Method Update:Void()
		Super.Update()
		
		If (_isIntro) Then
			_introText.Alpha = _introTween.value
			
			If (FlxG.Keys.JustPressed(KEY_ENTER)) Then
				FlxG.Play(Assets.SOUND_KEY)
			
				_isIntro = False
				_intro.Kill()
				_background.visible = False
				
				Init()
				context.layout.displayButton.Checked = True				
			End If
			
			Return
		End If
		
		If ( Not _fadeTween.active And levelMap.programStack.IsComplete()) Then
			context.layout.runButton.Checked = False
		
			If (levelMap.programStack.HasError()) Then
			
				If ( Not _errorOccured) Then
					Console.GetInstance().Push("Stage failed")
					If (levelMap.programStack.Reason) Console.GetInstance().Push(levelMap.programStack.Reason)
					_errorOccured = True
				End If
			Else
				Local isValid:Bool = levelMap.IsValid()
				
				If (isValid And Not _fadeTween.active) Then
					Console.GetInstance().Push("Stage complete")
					_background.visible = True
					_fadeTween.complete = _fadeTweenListener
					_fadeTween.Tween(0, 1, 1, Ease.SineInOut)
					_fadeTween.Start()
					
				ElseIf( Not isValid And Not _errorOccured)
					Console.GetInstance().Push("Stage failed")
					
					If ( Not levelMap.ChipIsMissed()) Then
						Console.GetInstance().Push("Target was not reached")
					Else
						Console.GetInstance().Push("Chip was missed")
					End If
					
					_errorOccured = True
				End If
				
				
			End If
		End If
		
		If (_fadeTween.active) Then
			_background.Alpha = _fadeTween.value
		End If
	End Method
	
	Method TurnOn:Void(window:Int)
		Select window
			Case CMD_WINDOW			
				_background.visible = True
				codeEditor.visible = True
				codeEditor.active = True
				Console.GetInstance().Empty()
				
				If (context.layout.runButton.On) Then
					context.layout.runButton.Checked = False
					levelMap.ReloadLevel()
				End If
			
			Case HELP_WINDOW
				_background.visible = True
				help.visible = True
				help.active = True
				
				If (context.layout.runButton.On) Then
					context.layout.runButton.Checked = False
					levelMap.ReloadLevel()
				End If
			
			Case MAP_WINDOW
				levelMap.visible = True
				levelMap.active = True
				If (context.layout = Null Or Not context.layout.runButton.On) levelMap.PutInfo()
				
		End Select
	
		_camera.Shake(0.005, 0.1)
	End Method
	
	Method TurnOff:Void(window:Int)
		Select window
			Case CMD_WINDOW
				_background.visible = False
				codeEditor.visible = False
				codeEditor.active = False
				
			
			Case HELP_WINDOW
				_background.visible = False
				help.visible = False
				help.active = False
			
			Case MAP_WINDOW
				levelMap.visible = False
				levelMap.active = False
		End Select
	End Method
	
	Method Exec:Void()
		If (levelMap.programStack.IsComplete() Or levelMap.programStack.HasError()) Then
			levelMap.ReloadLevel()
		End If
		
		_errorOccured = False
		levelMap.programStack.Exec(codeEditor.GetSource())
	End Method
	
	Method OnTweenComplete:Void()
		Local hertzLineSmall:FlxSprite = New FlxSprite(0, height)
		hertzLineSmall.MakeGraphic(width, height * 0.1)
		hertzLineSmall.Alpha = 0.05
	
		Local hertzSmallTween:LinearMotion = New LinearMotion(, FlxTween.LOOPING)
		hertzSmallTween.SetMotionSpeed(hertzLineSmall.x, hertzLineSmall.y, hertzLineSmall.x, -_hertzLine.height, 100)
		hertzSmallTween.SetObject(hertzLineSmall)
		
		hertzLineSmall.AddTween(hertzSmallTween)
		Add(hertzLineSmall)
	End Method
	
	Method OnModuleAdded:Void(m:Int)
		Select m
			Case 3
				Local psModule:PsModule = New PsModule()
				codeEditor.AddModule(psModule)
				levelMap.programStack.AddModule(psModule)
				
			Case 4
				Local plModule:PlModule = New PlModule()
				codeEditor.AddModule(plModule)
				levelMap.programStack.AddModule(plModule)
				
			Case 5
				Local rtModule:RtModule = New RtModule()
				codeEditor.AddModule(rtModule)
				levelMap.programStack.AddModule(rtModule)
		End Select
	End Method
	
	Method IsIntro:Bool() Property
		Return _isIntro
	End Method

End Class

Class FadeInTweenListener Implements FlxTweenListener

Private
	Field _display:Display
	
	Field _fadeOutListener:FadeOutTweenListener
	
	Method New(context:Display)
		_display = context
		_fadeOutListener = New FadeOutTweenListener(context)
	End Method

	Method OnTweenComplete:Void()
		_display._currentLevel += 1
		
		If (_display._currentLevel > Game.LEVELS_COUNT) Then
			_display._intro.ReviveAll()
			
			_display._introSprite.Play("unbox", True)
			_display.levelMap.programStack.Reset()
			_display.codeEditor.Reset()
			_display.help.Reset()
			
			_display._isIntro = True
			_display.codeEditor.Empty()
			Console.GetInstance().Empty()
			
			Console.GetInstance().Title("")
			Console.GetInstance().Push("All available tests")
			Console.GetInstance().Push("were completed")
			Console.GetInstance().Push("Codename E. was placed")
			Console.GetInstance().Push("in standby mode")
			Console.GetInstance().Push("You will be notified")
			Console.GetInstance().Push("about New tests")
			
			Return
		End If
		
		_display.levelMap.LoadLevel(_display._currentLevel)
		_display.codeEditor.Empty()
	
		_display._fadeTween.complete = _fadeOutListener
		_display._fadeTween.Tween(1, 0, 1, Ease.SineInOut)
		_display._fadeTween.Start()
	End Method
	
End Class

Class FadeOutTweenListener Implements FlxTweenListener

Private
	Field _display:Display
	
	Method New(context:Display)
		_display = context
	End Method

	Method OnTweenComplete:Void()
		_display._fadeTween.complete = Null
		_display._background.Alpha = 1
		_display._background.visible = False
	End Method
	
End Class
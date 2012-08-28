Strict

Import flixel

Import assets
Import codeeditor
Import levelmap
Import playstate
Import modules
Import help

Class Display Extends FlxGroup Implements FlxTweenListener

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
	
Public
	Method New(context:PlayState, camera:FlxCamera)
		Cameras =[camera.ID]
		width = camera.Width
		height = camera.Height
		
		_camera = camera
		Self.context = context
		
		_background = New FlxSprite(0, 0, Assets.SPRITE_DISPLAY_MAIN)
		_background.visible = False
		Add(_background)
		
		codeEditor = New CodeEditor(15, 15, width - 30, height)
		codeEditor.visible = False
		Add(codeEditor)
		
		help = New Help(30, 15)
		help.visible = False
		Add(help)
		
		levelMap = New LevelMap(Self)
		levelMap.visible = False
		
		_currentLevel = 8
		levelMap.LoadLevel(_currentLevel)
		
		Add(levelMap)
		
		_hertzLine = New FlxSprite(0, camera.Height)
		_hertzLine.MakeGraphic(camera.Width, camera.Height * 0.25)
		_hertzLine.Alpha = 0.05
		
		Local hertzTween:LinearMotion = New LinearMotion(, FlxTween.LOOPING)
		hertzTween.SetMotionSpeed(_hertzLine.x, _hertzLine.y, _hertzLine.x, -_hertzLine.height, 100)
		hertzTween.SetObject(_hertzLine)
				
		_hertzLine.AddTween(hertzTween)
		Add(_hertzLine)
		
		AddTween(New Alarm(6, Self), True)
		
		Local mfModule:MfModule = New MfModule()
		codeEditor.AddModule(mfModule)
		levelMap.programStack.AddModule(mfModule)
		
		Local mrModule:MrModule = New MrModule()
		codeEditor.AddModule(mrModule)
		levelMap.programStack.AddModule(mrModule)
		
		Local mlModule:MlModule = New MlModule()
		codeEditor.AddModule(mlModule)
		levelMap.programStack.AddModule(mlModule)
		
		Local psModule:PsModule = New PsModule()
		codeEditor.AddModule(psModule)
		levelMap.programStack.AddModule(psModule)
		
		Local plModule:PlModule = New PlModule()
		codeEditor.AddModule(plModule)
		levelMap.programStack.AddModule(plModule)
	End Method
	
	Method Update:Void()
		Super.Update()
		
		If (levelMap.programStack.IsComplete()) Then
			If (levelMap.programStack.HasError()) Then
				
			Else
				If (levelMap.IsValid()) Then
					_currentLevel += 1
					levelMap.LoadLevel(_currentLevel)
				End If
			End If
		End If		
	End Method
	
	Method TurnOn:Void(window:Int)
		Select window
			Case CMD_WINDOW
				_background.visible = True
				codeEditor.visible = True
				
				If (context.layout.runButton.On) Then
					context.layout.runButton.Checked = False
				End If
			
			Case HELP_WINDOW
				_background.visible = True
				help.visible = True
				
				If (context.layout.runButton.On) Then
					context.layout.runButton.Checked = False
				End If
			
			Case MAP_WINDOW
				levelMap.visible = True
				
		End Select
	
		_camera.Shake(0.005, 0.2)
	End Method
	
	Method TurnOff:Void(window:Int)
		Select window
			Case CMD_WINDOW
				_background.visible = False
				codeEditor.visible = False
			
			Case HELP_WINDOW
				_background.visible = False
				help.visible = False
			
			Case MAP_WINDOW
				levelMap.visible = False
		End Select
	End Method
	
	Method Exec:Void()
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

End Class
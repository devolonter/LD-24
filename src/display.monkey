Strict

Import flixel

Import assets
Import codeeditor
Import levelmap
Import playstate

Class Display Extends FlxGroup Implements FlxTweenListener

	Const CMD_WINDOW:Int = 1
	
	Const HELP_WINDOW:Int = 2
	
	Const MAP_WINDOW:Int = 3

	Field width:Float
	
	Field height:Float
	
	Field codeEditor:CodeEditor
	
	Field levelMap:LevelMap
	
	Field context:PlayState

Private
	Field _background:FlxSprite

	Field _hertzLine:FlxSprite
	
	Field _camera:FlxCamera
	
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
		
		levelMap = New LevelMap()
		levelMap.visible = False
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
			
			Case MAP_WINDOW
				levelMap.visible = False
				
		End Select
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
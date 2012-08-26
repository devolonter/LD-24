Strict

Import flixel

Class Display Extends FlxGroup Implements FlxTweenListener

	Field width:Float
	
	Field height:Float

Private
	Field _hertzLine:FlxSprite
	
	Method New(camera:FlxCamera)
		Cameras =[camera.ID]
		width = camera.Width
		height = camera.Height
		
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
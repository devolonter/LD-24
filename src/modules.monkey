Strict

Import flixel

Interface Module
	
	GetCommands:Command[] ()

	Exec:Void(command:String)

End Interface

Class Command

	Field name:String
	
	Field description:String
	
	Field value:String
	
	Method New(name:String, value:String, description)
		Self.name = name
		Self.value = value
		Self.description = description
	End Method

End Class

Class MovementModule
	
	Method New()
		
	End Method

End Class
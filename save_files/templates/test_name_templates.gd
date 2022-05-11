extends Resource

export(String)            var template_name:String   = "test_name"
export(int)               var template_type:int      = 1
export(Array, Dictionary) var template_prompts:Array = [
	{
		'name'        : 'Name',
		'description' : 'name of the place/region that will help identify it',
		'type'        :  PresetInputManager.TEXT,
		'value'       : '',
		'display'     : '[font=res://test_font.tres]Name[/font]\nthe name of the land is {value}',
		'null_value'  : 'unknown'
	},
	
	{
		'name'        : 'Description',
		'description' : 'long form description of the place',
		'type'        :  PresetInputManager.BIG_TEXT,
		'display'     : '\n{value}',
		'null_value'  : ''
	},
	
	{
		'name'        : 'Hospitable',
		'description' : 'click the checkbox if the place is hospitable',
		'type'        : PresetInputManager.TOGGLE_BUTTON,
		'value'       : true,
		'display'     : '[font=res://test_font.tres]Hospitable[/font]\nthis place is{value} fit for living',

		'input_value_if_true'  : '',
		'input_value_if_false' : ' not'
	}
]

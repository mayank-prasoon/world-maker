extends Resource

export(String)            var template_name:String   = "test_name"
export(int)               var template_type:int      = 1
export(Array, Dictionary) var template_prompts:Array = [
	{
		'name'        : 'Name',
		'description' : 'name of the place/region that will help identify it',
		'type'        :  PresetInputManager.TEXT,
		'value'       : '',
		'display'     : 'the name of the land is {value}',
		'null_value'  : 'unknown'
	},
	
	{
		'name'        : 'Description',
		'description' : 'long form description of the place',
		'type'        :  PresetInputManager.BIG_TEXT,
		'display'     : '{value}',
		'null_value'  : ''
	},
	
	{
		'name'        : 'Hospitable',
		'description' : 'click the checkbox if the place is hospitable',
		'type'        : PresetInputManager.TOGGLE_BUTTON,
		'value'       : true,
		'display'     : 'this place is{value} fit for living',

		'input_value_if_true'  : '',
		'input_value_if_false' : ' not'
	}
]

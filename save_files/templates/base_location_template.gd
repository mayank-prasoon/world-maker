extends Resource

export(String)            var template_name:String   = "basic pin template"
export(int)               var template_type:int      = Article.PIN
export(Array, Dictionary) var template_prompts:Array = [
	{
		'name'        : 'Name Location',
		'description' : 'name of the place/region that will help identify it',
		'type'        :  PresetInputManager.TEXT,
		'value'       : '',
		'display'     : '[font=res://Header.tres]Name[/font]\nthe name of the land is {value}',
		'null_value'  : 'unknown'
	},
	
		{
		'name'        : 'Local Name',
		'description' : 'name of the place/region that will help identify it',
		'type'        :  PresetInputManager.TEXT,
		'value'       : '',
		'display'     : '\nthis place is also know as {value}',
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
	},

	{
		'name'        : 'Description',
		'description' : 'long form description of the place',
		'type'        :  PresetInputManager.BIG_TEXT,
		'display'     : '\n{value}',
		'null_value'  : ''
	},

	{
		'name'        : 'Biome',
		'description' : 'select the name of the Biome',
		'type'        : PresetInputManager.DROPDOWN,
		'input_dropdown_option' : [
				'Tundra',
				'Desert',
				'Savana',
				'Mountains',
				'Grasslands',
				'Rain forest',
				'Polar region',
				'Tropical forest',
				'Taiga (Boreal Forest)',
				'Northern Conifer Forest',
				'Mediterranean scrub forest',
				'Temperate Deciduous Forest'
			],
		'value'       : true,
		'display'     : '[font=res://test_font.tres]Type of Biome[/font]\nthis place is a{value}',
	},

	{
		'name'        : 'Description',
		'description' : 'long form description of the place',
		'type'        :  PresetInputManager.BIG_TEXT,
		'display'     : '\n{value}',
		'null_value'  : ''
	},

	{
		'name'        : 'Height Above Sea level',
		'description' : 'height above sea level:\nhow above the land from the sea level in meters(m)',
		'type'        :  PresetInputManager.SPINBOX,
		'display'     : '\n[font=res://test_font.tres]Geography[/font]\nthis place is {value}m above sea level',
		'input_spin_box_suffix' : 'm',
		'null_value'  : ''
	},

	{
		'name'        : 'Area',
		'description' : 'Area of that location in meter sq.',
		'type'        :  PresetInputManager.SPINBOX,
		'display'     : '\nThis place is {value}m sq. in area',
		'input_spin_box_suffix' : 'm sq.',
		'null_value'  : ''
	},

	{
		'name'        : 'Temprature',
		'description' : 'avarage temprature of the place in °C',
		'type'        :  PresetInputManager.SPINBOX,
		'display'     : '\nTemprature of the place is {value}°C on avarage',
		'input_spin_box_suffix' : '°C',
		'null_value'  : ''
	},

	{
		'name'        : 'Snow Fall',
		'description' : 'Avarage snow fall of the location (calculated in cm)',
		'type'        :  PresetInputManager.SPINBOX,
		'display'     : '\nSnow Fall of the place is {value}cm on avarage',
		'input_spin_box_suffix' : 'cm',
		'null_value'  : ''
	},

	{
		'name'        : 'Rain Fall',
		'description' : 'Avarage rain fall of the location (calculated in cm)',
		'type'        :  PresetInputManager.SPINBOX,
		'display'     : '\nRain Fall of the place is {value}cm on avarage',
		'input_spin_box_suffix' : 'cm',
		'null_value'  : ''
	},

#	{
#		'name'        : 'Atmospheric Pressure',
#		'description' : 'avarage temprature of the place in °C',
#		'type'        :  PresetInputManager.SPINBOX,
#		'display'     : '\nTemprature of the place is {value}°C on avarage',
#		'input_spin_box_suffix' : '°C',
#		'null_value'  : ''
#	},

	{
		'name'        : 'Greographical Formations',
		'description' : 'Greographical formation in the area',
		'type'        :  PresetInputManager.DATABASE,
		'display'     : '\nthere are {value} in the area ',
		'null_value'  : 'no geographical formations'
	},

	{
		'name'        : 'Item Found',
		'description' : 'Item found in the area',
		'type'        :  PresetInputManager.DATABASE,
		'display'     : '\nthere is/are {value} in the area ',
		'null_value'  : 'no item'
	},

	{
		'name'        : 'Flora',
		'description' : 'Flora in the area',
		'type'        :  PresetInputManager.DATABASE,
		'display'     : '\nthere is/are {value} in the area ',
		'null_value'  : 'no flora'
	},

	{
		'name'        : 'Fauna',
		'description' : 'Fauna found in the area',
		'type'        :  PresetInputManager.DATABASE,
		'display'     : '\nthere is/are {value} in the area ',
		'null_value'  : 'no fauna'
	},

	{
		'name'        : 'Structures',
		'description' : 'Structures found in the area',
		'type'        :  PresetInputManager.DATABASE,
		'display'     : '\nthere is/are {value} in the area ',
		'null_value'  : 'no structures'
	},

	{
		'name'        : 'Laws',
		'description' : 'Laws in the area',
		'type'        :  PresetInputManager.DATABASE,
		'display'     : '\n{value}',
		'null_value'  : ''
	},

	{
		'name'        : 'History',
		'description' : 'long form history of the place',
		'type'        :  PresetInputManager.BIG_TEXT,
		'display'     : '\n\n{value}',
		'null_value'  : ''
	},

	{
		'name'        : 'Concept Art',
		'description' : 'select an image as concept art',
		'type'        :  PresetInputManager.IMAGE,
		'display'     : '\n[font=res://test_font.tres]Concept arts[/font]\n{value}',
		'input_spin_box_suffix' : 'm',
		'null_value'  : ''
	},

	{
		'name'        : 'Concept Art',
		'description' : 'select an image as concept art',
		'type'        :  PresetInputManager.IMAGE,
		'display'     : '\n{value}',
		'input_spin_box_suffix' : 'm',
		'null_value'  : ''
	},

	{
		'name'        : 'Concept Art',
		'description' : 'select an image as concept art',
		'type'        :  PresetInputManager.IMAGE,
		'display'     : '\n{value}',
		'input_spin_box_suffix' : 'm',
		'null_value'  : ''
	},

]

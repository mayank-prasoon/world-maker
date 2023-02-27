<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# base\_location\_template.gd

**Extends:** [Resource](../Resource)

## Description

## Property Descriptions

### template\_name

```gdscript
export var template_name: String = "Basic Pin Template"
```

### template\_type

```gdscript
export var template_type: int = 2
```

### template\_prompts

```gdscript
export var template_prompts: Array = [{"description":"name of the place/region that will help identify it","display":"[font=res://Header.tres]Name[/font]\nName of this place is {value}.","name":"Name Location","null_value":"unknown","type":0,"value":""},{"description":"name of the place/region that will help identify it","display":"this place is also know as {value}.","name":"Local Name","null_value":"unknown","type":0,"value":""},{"description":"long form description of the place","display":"{value}","name":"Description","null_value":"","type":1},{"description":"click the checkbox if the place is hospitable","display":"\n[font=res://Header.tres]Hospitable[/font]\nthis place is{value} fit for living.","input_value_if_false":" not","input_value_if_true":"","name":"Hospitable","type":5,"value":true},{"description":"long form description of the place","display":"{value}","name":"Description","null_value":"","type":1},{"description":"select the name of the Biome","display":"\n[font=res://Header.tres]Type of Biome[/font]\nthis place is a{value}","input_dropdown_option":["Tundra","Desert","Savana","Mountains","Grasslands","Rain forest","Polar region","Tropical forest","Taiga (Boreal Forest)","Northern Conifer Forest","Mediterranean scrub forest","Temperate Deciduous Forest"],"name":"Biome","type":3,"value":true},{"description":"long form description of the place","display":"\n{value}","name":"Description","null_value":"","type":1},{"description":"height above sea level:\nhow above the land from the sea level in meters(m)","display":"\n[font=res://Header.tres]Geography[/font]\nThis place is {value} above sea level.","input_spin_box_suffix":"m","name":"Height Above Sea level","null_value":"0 m","type":4},{"description":"Area of that location in meter sq.","display":"This place is {value} in area.","input_spin_box_suffix":"m sq.","name":"Area","null_value":"0 m sq.","type":4},{"description":"avarage temprature of the place in °C","display":"Temprature of the place is {value} on avarage.","input_spin_box_suffix":"°C","name":"Temprature","null_value":"0 °C","type":4},{"description":"Avarage snow fall of the location (calculated in cm)","display":"This place recives {value} of snow fall on avarage.","input_spin_box_suffix":"cm","name":"Snow Fall","null_value":"0 cm","type":4},{"description":"Avarage rain fall of the location (calculated in cm)","display":"Rain Fall of the place is {value} on avarage.","input_spin_box_suffix":"cm","name":"Rain Fall","null_value":"0 cm","type":4},{"description":"Greographical formation in the area","display":"There are {value} in the area ","name":"Greographical Formations","null_value":"no geographical formations","type":7},{"description":"Item found in the area","display":"There is/are {value} in the area ","name":"Item Found","null_value":"no item","type":7},{"description":"Flora in the area","display":"There is/are {value} in the area ","name":"Flora","null_value":"no flora","type":7},{"description":"Fauna found in the area","display":"There is/are {value} in the area ","name":"Fauna","null_value":"no fauna","type":7},{"description":"Structures found in the area","display":"There is/are {value} in the area ","name":"Structures","null_value":"no structures","type":7},{"description":"Laws in the area","display":"There is/are {value} in the area ","name":"Laws","null_value":"no Laws","type":7},{"description":"long form history of the place","display":"\n\n{value}","name":"History","null_value":"","type":1},{"description":"select an image as concept art","display":"\n[font=res://Header.tres]Concept arts[/font]\n{value}","input_spin_box_suffix":"m","name":"Concept Art","null_value":"","type":2},{"description":"select an image as concept art","display":"\n\n{value}","input_spin_box_suffix":"m","name":"Concept Art","null_value":"","type":2},{"description":"select an image as concept art","display":"\n\n{value}","input_spin_box_suffix":"m","name":"Concept Art","null_value":"","type":2}]
```


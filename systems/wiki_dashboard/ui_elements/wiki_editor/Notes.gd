extends Control

onready var textedit:TextEdit = $VBoxContainer/TextEdit

func _on_Bold_pressed():
	textedit.insert_text_at_cursor('[b]' + textedit.get_selection_text() + '[/b]')


func _on_Italic_pressed():
	textedit.insert_text_at_cursor('[i]' + textedit.get_selection_text() + '[/i]')


func _on_Underline_pressed():
	textedit.insert_text_at_cursor('[u]' + textedit.get_selection_text() + '[/u]')


func _on_strikethrough_pressed():
	textedit.insert_text_at_cursor('[s]' + textedit.get_selection_text() + '[/s]')


func _on_Heading_pressed():
	textedit.insert_text_at_cursor('[font=res://Header.tres]' + textedit.get_selection_text() + '[/font]')


func _on_Code_pressed():
	textedit.insert_text_at_cursor('[indent][indent][code]' + textedit.get_selection_text() + '[/code][/indent][/indent]')


func _on_Quote_pressed():
	textedit.insert_text_at_cursor('[indent][indent][font=res://Quote.tres]' + textedit.get_selection_text() + '[/font][/indent][/indent]')


func _on_Fill_pressed():
	textedit.insert_text_at_cursor('[fill]' + textedit.get_selection_text() + '[/fill]')

func _on_Center_pressed():
	textedit.insert_text_at_cursor('[center]' + textedit.get_selection_text() + '[/center]')


func _on_Right_pressed():
	textedit.insert_text_at_cursor('[right]' + textedit.get_selection_text() + '[/right]')

extends Control

# button pressed button method
func _on_Button_pressed():
	self.hide()

# open article signal method
func open_article(article:Article):
	self.show()

# load article signal method
func load_article():
	pass

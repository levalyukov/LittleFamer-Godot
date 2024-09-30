extends Control

@onready var main_scene = str(get_tree().root.get_child(1).name)
@onready var craft:Control = get_node("/root/" + main_scene + "/UI/Windows/Crafting")
@onready var blur:Control = get_node("/root/" + main_scene + "/UI/GUI/Blur")

func _on_button_pressed():
	if !blur.state:
		craft.open()
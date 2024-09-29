extends Node2D

@onready var main_scene = str(get_tree().root.get_child(1).name)
@onready var manager = get_node("/root/" + main_scene)
@onready var pause:Control = get_node("/root/" + main_scene + "/UI/Windows/Pause")
@onready var tip:Control = get_node("/root/" + main_scene + "/UI/GUI/Tooltip")
@onready var grid:Node2D = get_node("/root/" + main_scene + "/Buildings/Grid")
@onready var blur:Control = get_node("/root/" + main_scene + "/UI/GUI/Blur")
@onready var player:CharacterBody2D = get_node("/root/" + main_scene + "/Camera")
@onready var sprite:Sprite2D = $Sprite2D

var max_distance:int = 250
var object:Dictionary = {
	"caption" = tr("tablet.caption"),
	"description" = tr("tablet.description"),
	"default" = load("res://assets/resources/buildings/tablet/tablet_0.png"),
	"hover" = load("res://assets/resources/buildings/tablet/tablet_1.png"),
}

func _ready():
	if object.has("default"):
		if typeof(object["default"]) == TYPE_OBJECT and sprite.texture is CompressedTexture2D:
			sprite.texture = object["default"]
		else:
			print_debug("\n"+str(manager.get_system_datetime()) + " ERROR: The specified sprite cannot be installed.")
	else:
		print_debug("\n"+str(manager.get_system_datetime()) + " ERROR: The specified key is missing.")

func _change_sprite(type:bool) -> void:
	if type:
		var distance = round(global_position.distance_to(player.global_position))
		if grid.mode == grid.modes.NOTHING and distance < max_distance:
			_check_sprite("hover")
			if object.has("caption")\
			and object.has("description"):
				tip.tooltip(
					object["caption"]+"\n"
					+object["description"]
				)
			else:
				print_debug("\n"+str(manager.get_system_datetime()) + " ERROR: Check the 'caption', 'description' elements.")
	else:
		_check_sprite("default")
		tip.tooltip("")
	
func _check_sprite(key:String) -> void:
	if object.has(key):
		if typeof(object[key]) == TYPE_OBJECT and sprite.texture is CompressedTexture2D:
			sprite.texture = object[key]
		else:
			print_debug("\n"+str(manager.get_system_datetime()) + " ERROR: The specified sprite cannot be installed.")
	else:
		print_debug("\n"+str(manager.get_system_datetime()) + " ERROR: The specified key is missing.")

func _on_area_2d_mouse_entered() -> void:
	if !blur.state:
		_change_sprite(true)

func _on_area_2d_mouse_exited() -> void:
	_change_sprite(false)

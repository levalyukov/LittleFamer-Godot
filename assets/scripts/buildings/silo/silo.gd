extends Node2D

@onready var main_scene = str(get_tree().root.get_child(1).name)
@onready var manager = get_node("/root/" + main_scene)
@onready var tip:Control = get_node("/root/" + main_scene + "/User Interface/System/Tooltip")
@onready var pause:Control = get_node("/root/" + main_scene + "/User Interface/Windows/Pause")
@onready var grid:Node2D = get_node("/root/" + main_scene + "/Buildings/Grid") 
@onready var blur:Control = get_node("/root/" + main_scene + "/User Interface/Blur")
@onready var player:CharacterBody2D = get_node("/root/" + main_scene + "/Camera")
@onready var sprite:Sprite2D = $Sprite2D

var max_distance:int = 250
var level:int = 1
var object:Dictionary = {
	1: {
		"caption" = tr("silo.caption"),
		"description" = tr("silo.description"),
		"default" = load("res://assets/resources/buildings/silo/level-1/object_0.png"),
		"hover" = load("res://assets/resources/buildings/silo/level-1/object_1.png"),
	},
}

func _ready():
	update()

func update():
	if object.has(level):
		if object[level].has("default"):
			sprite.texture = object[level]["default"]
		else:
			print_debug("\n"+str(manager.get_system_datetime()) + " ERROR: There is no key at index " + str(level) + ".")
	else:
		print_debug("\n"+str(manager.get_system_datetime()) + " ERROR: Index " + str(level) + " is not in the dictionary.")

func _change_sprite(type:bool):
	if type:
		var distance = round(global_position.distance_to(player.global_position))
		if grid.mode == grid.modes.NOTHING and distance < max_distance:
			if object.has(level):
				_check_sprite("hover")
				var level_text = tr("object.level")
				tip.tooltip(
					str(object[level]["caption"]) + "\n" +
					str(object[level]["description"]) + "\n" +
					str(level_text) + str(level)
					)
	else:
		_check_sprite("default")
		tip.tooltip("")

func _check_sprite(key:String):
	if object.has(level):
		if object[level].has(key):
			if typeof(object[level][key]) == TYPE_OBJECT and sprite.texture is CompressedTexture2D:
				sprite.texture = object[level][key]
			else:
				print_debug("\n"+str(manager.get_system_datetime()) + " ERROR: The specified sprite cannot be installed.")
		else:
			print_debug("\n"+str(manager.get_system_datetime()) + " ERROR: There is no key at index " + str(level) + ".")
	else:
		print_debug("\n"+str(manager.get_system_datetime()) + " ERROR: Index " + str(level) + " is not in the dictionary.")

func get_data():
	if object.has(level):
		return {"level": level}

func load_data(obj_level:int) -> void:
	self.level = obj_level
	update()

func _on_collision_mouse_entered():
	if !blur.state:
		_change_sprite(true)

func _on_collision_mouse_exited():
	_change_sprite(false)

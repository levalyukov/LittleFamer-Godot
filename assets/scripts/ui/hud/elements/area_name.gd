extends MarginContainer

@onready var main_scene = str(get_tree().root.get_child(1).name)
@onready var manager:Node2D = get_node("/root/" + main_scene)
@onready var anim:AnimationPlayer = $AnimationPlayer
@onready var label:Label = $Label
@onready var timer:Timer = $Timer

var state:bool = false
const time:int = 5

func _ready():
	await get_tree().create_timer(1.5).timeout
	show_area_name()

func show_area_name():
	state = true
	label.text = str(manager.get_name_target_scene())
	anim.play("show")
	timer.wait_time = time
	timer.start()

func hide_area_name():
	anim.play("hide")
	state = false

func check_state():
	visible = state

func _on_timer_timeout():
	hide_area_name()
	timer.stop()

extends Node2D

@onready var game_logotype:Control = $Canvas/MainMenu/Main/Buttons/Logotype/Logotype
@onready var version:Label = $Canvas/MainMenu/Main/Credits/Version
@onready var background:ColorRect = $Canvas/MainMenu/Background
@onready var blackout:Control = $Canvas/MainMenu/Blackout
@onready var logo_anim:AnimationPlayer = $Canvas/MainMenu/AnimationLogotype
@onready var str_anim:AnimationPlayer = $Canvas/MainMenu/Main/Credits/AnimationString

@onready var countinue_button = $Canvas/MainMenu/Main/Buttons/ButtonsContainer/HBoxContainer/CountinueGameMaring/CountinueGameButton
@onready var newgame_button = $Canvas/MainMenu/Main/Buttons/ButtonsContainer/HBoxContainer/NewGameMargin/NewGameButton
@onready var options_button = $Canvas/MainMenu/Main/Buttons/ButtonsContainer/HBoxContainer/OptionsMargin/OptionsButton
@onready var quit_button = $Canvas/MainMenu/Main/Buttons/ButtonsContainer/HBoxContainer/QuitMargin/QuitButton

var clicked:bool = true
var version_string_state:bool
var logotype_state:bool

func _ready():
	var app_version = ProjectSettings.get_setting("application/config/version")
	var copyright = "© Studio Miroro"
	version.text = "v" + app_version + "\n" + copyright
	change_button_state(false)
	blackout.visible = true
	await get_tree().create_timer(1.25).timeout
	blackout.blackout(false, 4)
	await get_tree().create_timer(0.25).timeout
	clicked = false

func change_button_state(state:bool) -> void:
	countinue_button.buttons_state(state)
	newgame_button.buttons_state(state)
	options_button.buttons_state(state)
	quit_button.buttons_state(state)
	_change_logo_state(state)
	_change_string_state(state)

func _change_logo_state(state:bool) -> void:
	match state:
		true:
			_logo_hide()
		false:
			_logo_show()

func _logo_hide() -> void:
	logo_anim.play("logotype_hide")
	logotype_state = false

func _logo_show() -> void:
	logo_anim.play("logotype_show")
	logotype_state = true

func _check_logo_state() -> void:
	game_logotype.visible = logotype_state

func _change_string_state(state: bool) -> void:
	match state:
		true:
			_version_string_hide()
		false:
			_version_string_show()

func _version_string_hide() -> void:
	str_anim.play("version_string_hide")
	version_string_state = false

func _version_string_show() -> void:
	str_anim.play("version_string_show")
	version_string_state = true

func _check_string_state() -> void:
	version.visible = version_string_state

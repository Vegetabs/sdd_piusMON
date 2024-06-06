extends Control

@onready var left_fs = $left_fs
@onready var right_fs = $right_fs
@onready var fs_text = $fs_text
var fullscreen = false

func _ready():
	_update_fs_text(fullscreen)

func get_screen_mode() -> bool:
	return fullscreen

func _update_fs_text(val:bool) -> void:
	fs_text.text = "{fs}".format({"fs":bool_to_str(val)})

func bool_to_str(val:bool) -> String:
	if val == true:
		return "ON"
	else:
		return "OFF"

func _on_left_fs_button_down():
	if fullscreen == true:
		fullscreen = false
		_update_fs_text(fullscreen)

func _on_right_fs_button_down():
	if fullscreen == false:
		fullscreen = true
		_update_fs_text(fullscreen)

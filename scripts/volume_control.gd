extends Control

@onready var left_volume = $left_volume
@onready var right_volume = $right_volume
@onready var volume_text = $volume_text
var volume = 100

func _ready():
	_update_volume_text(volume)

func get_volume() -> int:
	return volume

func _update_volume_text(val:int) -> void:
	volume_text.text = "{vol}".format({"vol":val})

func _on_left_volume_button_down():
	if volume >= 5:
		volume -= 5
		_update_volume_text(volume)

func _on_right_volume_button_down():
	if volume <= 95:
		volume += 5
		_update_volume_text(volume)

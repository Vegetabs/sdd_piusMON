extends Control

@onready var file_path := "res://data/player_data.json"
@onready var win_text = $win_text
@onready var loss_text = $loss_text
@onready var ratio_text = $ratio_text

func _ready():
	var stats = get_stats()
	win_text.set_win(stats["win"])
	loss_text.set_loss(stats["loss"])
	ratio_text.set_ratio(stats["win"]/stats["loss"])

func get_stats() -> Dictionary:
	var data_txt = FileAccess.get_file_as_string(file_path)
	var data_dict = JSON.parse_string(data_txt)
	return data_dict

func _on_back_button_button_down():
	self.queue_free()

extends Control

@onready var timer = $Timer
@onready var title = $end_title
@onready var win_txt = $win_txt
@onready var loss_txt = $loss_txt
@onready var ratio_txt = $ratio_txt
@onready var anim = $scene_change_anim
@onready var file_path = "res://data/player_data.json"
@onready var stat_dict = get_stats()
var ratio = 0
var timer_num = 0

func _ready():
	ResourcePaths.get_json_data("player_data")
	SignalBus.send_battle_info.connect(_load_info)

func _load_info(team:String) -> void:
	_update_stats(team)
	_set_title_text(team)
	_set_win_text()
	_set_loss_text()
	_set_ratio_text()
	_update_data_file(stat_dict)

func _update_stats(losing_team:String) -> void:
	if losing_team == "enemy":
		stat_dict["win"] += 1
	elif losing_team == "player":
		stat_dict["loss"] += 1
	ratio = snapped(stat_dict["win"]/stat_dict["loss"],0.01)

func _update_data_file(player_data) -> void:
	var data = JSON.stringify(player_data)
	var file = FileAccess.open(file_path,FileAccess.WRITE)
	file.store_string(data)
	file.close()

func _set_title_text(losing_team:String) -> void:
	if losing_team == "enemy":
		title.text = "YOU WON!"
	elif losing_team == "player":
		title.text = "YOU LOST"

func _set_win_text() -> void:
	win_txt.text = "Wins: {win}".format({"win":stat_dict["win"]})

func _set_loss_text() -> void:
	loss_txt.text = "Loss: {loss}".format({"loss":stat_dict["loss"]})

func _set_ratio_text() -> void:
	ratio_txt.text = "Ratio: {ratio}".format({"ratio":ratio})

func get_stats() -> Dictionary:
	var data_txt = FileAccess.get_file_as_string(file_path)
	var data_dict = JSON.parse_string(data_txt)
	return data_dict

func _on_timer_timeout():
	if timer_num == 0:
		anim.play("backward")
	elif timer_num == 1:
		anim.play("forward")

func _on_scene_change_anim_animation_finished(anim_name):
	if anim_name == "backward":
		timer.wait_time = 4.0
		timer.start()
		timer_num += 1
	elif anim_name == "forward":
		SignalBus.change_scene.emit("main_menu")

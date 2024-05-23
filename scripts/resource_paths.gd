extends Node

const type_path_dict = {
	0:"res://sprites/type_icon/rock_icon.png",
	1:"res://sprites/type_icon/paper_icon.png",
	2:"res://sprites/type_icon/scissor_icon.png"
}

const json_path_dict := {
	"mon_data":"res://data/mon_data.json",
	"player_data":"res://data/player_data.json",
	"settings":"res://data/settings.json"
}

func get_icon_path(icon_id:int) -> String:
	return type_path_dict[icon_id]

func get_json_data(file:String) -> Array:
	var data_txt = FileAccess.get_file_as_string(json_path_dict[file])
	var arr = JSON.parse_string(data_txt)
	return arr

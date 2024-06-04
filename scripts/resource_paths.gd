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

const mon_path_dict := {
	1:"res://sprites/entity_sprite/mon/spark_demon_combined.png",
	2:"res://sprites/entity_sprite/mon/slime_beast_combined.png",
	3:"res://sprites/entity_sprite/mon/orc_shamen_combined.png"
}

func get_icon_path(icon_id:int) -> String:
	return type_path_dict[icon_id]

func get_mon_path(mon_id:int) -> String:
	return mon_path_dict[mon_id]

func get_json_data(file:String) -> Array:
	var data_txt = FileAccess.get_file_as_string(json_path_dict[file])
	var arr = JSON.parse_string(data_txt)
	return arr

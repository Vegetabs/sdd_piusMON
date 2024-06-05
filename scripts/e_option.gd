extends Button

@onready var mon_data : Array = ResourcePaths.get_json_data("mon_data")
@onready var option_type = $option_type
@onready var option_icon = $option_icon
#var option_size := Vector2(160,160)

func generate_mon():
	#--Get random mon from mon_data.json--#
	var rand : int = randi_range(0,len(mon_data)-1)
	var mon_info : Dictionary = mon_data[rand]
	#--Load option icon using icon_path--#
	option_icon.texture = load(mon_info["icon"])
	#--Convert type int to path and load type icon--#
	var type_path : String = ResourcePaths.get_icon_path(int(mon_info["type"]))
	option_type.texture = load(type_path)
	#--Generate and get Mon stats--#
	var stats : Array = _generate_stats()
	var option_txt : String = _format_txt(mon_info,stats)
	self.text = option_txt
	#--Send mon info to team selection to be used for battle scene--#
	var mon_final = [mon_info["id"],stats]
	SignalBus.team_confirmed.emit(1,mon_final)
	

#func update_option(option_dict:Dictionary) -> void:
#	#--option_arr format: {id,name,type,icon_path}--#
#	option_dict["type"] = ResourcePaths.get_icon_path(int(option_dict["type"]))
#	self.text = _format_txt(option_dict)
#	option_icon.texture = load(option_dict["icon"])
#	option_type.texture = load(option_dict["type"])

func _format_txt(dict:Dictionary,stat_arr) -> String:
	var format_dict = {"name":dict["name"],"attack":stat_arr[0],"speed":stat_arr[1],"life":stat_arr[2]}
	var txt = "{name}\nAttack - {attack}\nSpeed - {speed}\nLife - {life}".format(format_dict)
	return txt

func _generate_stats() -> Array:
	var stats = []
	var stat_max = 80
	for i in range(0,3):
		var rand = randi_range(10,stat_max)
		stat_max = 100-rand-10
		stats.append(rand)
	return stats

#func _get_texture(path:String) -> CompressedTexture2D:
#	var img = load(path)
#	img.set_size(option_size)
#	return img

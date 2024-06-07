extends TextureRect

@onready var mon_texture = $mon_texture

func set_mon_texture(id:int) -> void:
	var mon_data = ResourcePaths.get_json_data("mon_data")
	for i in mon_data:
		if int(i["id"]) == id:
			mon_texture.texture = load(i["icon"])
			break

func remove_mon_texture() -> void:
	mon_texture.texture = null

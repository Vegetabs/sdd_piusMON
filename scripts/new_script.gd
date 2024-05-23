extends Control

var current_scene := ""

func _ready():
	_connect_signals()
	Settings.start()

func _connect_signals() -> void:
	SignalBus.setup_complete.connect(_start_startup)
	SignalBus.change_scene.connect(_change_scene)

func _load_scene(path:String) -> void:
	path = ScenePaths.str_to_path(path)
	var inst = load(path).instantiate()
	add_child(inst)

func _delete_scene(node_name:String) -> void:
	var startup = _get_node(node_name)
	if startup != null:
		startup.queue_free()

func _get_node(node_name:String) -> Node:
	var node = null
	for i in self.get_children():
		if i.name == node_name:
			node = i
	return node

func _change_scene(next_scene:String) -> void:
	_delete_scene(current_scene)
	_load_scene(next_scene)
	current_scene = next_scene

func _start_startup(): 
	_load_scene("startup")
	current_scene = "startup"

#func _finish_startup():
#	_delete_scene("startup")
#	_load_scene(main_menu_path)
#
#func _start_main_menu():
#	_load_scene(main_menu_path)
#
#func _start_team_selection():
#	_load_scene(team_selection_path)

#func _set_resolution(res):
#	self.resolution = res
#
#func _set_volume(new_volume):
#	self.volume = new_volume

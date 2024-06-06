extends Control

var current_scene := ""
@onready var music = $music_player
@onready var hit = $hit_sound
@onready var attack = $attack_sound

func _ready():
	_connect_signals()
	Settings.start()

func _connect_signals() -> void:
	SignalBus.setup_complete.connect(_start_startup)
	SignalBus.change_scene.connect(_change_scene)
	SignalBus.load_battle.connect(_load_battle)
	SignalBus.load_battle_end.connect(_load_result)
	SignalBus.update_real_volume.connect(_set_audio_volume)
	SignalBus.play_attack.connect(_play_attack)
	SignalBus.play_hit.connect(_play_hit)

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

func _start_startup() -> void: 
	_load_scene("startup")
	current_scene = "startup"

func _load_battle(p_team:Array,e_team:Array) -> void:
	_change_scene("battle")
	SignalBus.load_team.emit(p_team,e_team)

func _load_result(losing_team:String) -> void:
	_change_scene("battle_end")
	SignalBus.send_battle_info.emit(losing_team)
	pass

func _set_audio_volume() -> void:
	var vol = int(Settings.get_volume()*0.80)
	if vol < 80:
		vol = (80-vol)*-1
	else:
		vol = 0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), vol)

func _play_attack():
	attack.play()

func _play_hit():
	hit.play()

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

func _on_music_player_finished():
	music.play()

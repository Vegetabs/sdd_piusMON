extends Control

@onready var timer = $Timer
@onready var anim = $scene_change_anim

func _ready():
	#SignalBus.load_scene.connect(_load_window)
	timer.start()

func _load_window(path:String) -> void:
	path = ScenePaths.str_to_path(path)
	var inst = load(path).instantiate()
	add_child(inst)

func _on_timer_timeout():
	anim.play("backward")

func _on_battle_button_button_down():
	if anim.is_playing() == false:
		anim.play("forward")

func _on_scene_change_anim_animation_finished(anim_name):
	if anim_name == "forward":
		SignalBus.change_scene.emit("team_selection")

func _on_settings_button_button_down():
	_load_window("set_window")

func _on_stat_button_button_down():
	_load_window("stat_window")

func _on_info_button_button_down():
	_load_window("info_window")

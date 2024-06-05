extends Control

@onready var timer = $Timer
@onready var anim = $scene_change_anim
@onready var e_team_select = $e_team_selection
var mon_team := []
var e_mon_team := []
var scene_state := ""

func _ready():
	SignalBus.team_confirmed.connect(_team_update)
	e_team_select.start_selection()
	timer.start()

func _on_timer_timeout():
	anim.play("backward")

func _on_back_button_button_down():
	if anim.is_playing() == false:
		scene_state = "main_menu"
		anim.play("forward")

func _on_scene_change_anim_animation_finished(anim_name:String):
	print(scene_state)
	if anim_name == "forward" and scene_state != "":
		if scene_state == "main_menu":
			SignalBus.change_scene.emit(scene_state)
		elif scene_state == "battle":
			SignalBus.load_battle.emit(mon_team,e_mon_team)

func _on_accept_button_button_down():
	SignalBus.accept_team.emit()

func _team_update(team:int,data:Array) -> void:
	print(team)
	match team:
		0: #--Player team--#
			mon_team.append(data)
			print("hah")
			scene_state = "battle"
			anim.play("forward")
		1: #--Enemy team--#
			e_mon_team.append(data)
			print(data)
			print(e_mon_team)
		_: #--Exception--#
			assert(false,"Trying to update non-existent team")

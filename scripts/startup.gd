extends Control

@onready var timer = $Timer
@onready var anim = $scene_change_anim

func _ready():
	timer.start()

func _on_timer_timeout():
	anim.play("forward")

func _on_scene_change_anim_animation_finished(anim_name):
	if anim_name == "forward":
		SignalBus.change_scene.emit("main_menu")

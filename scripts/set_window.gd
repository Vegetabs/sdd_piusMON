extends Control

@onready var volume = $volume_control
@onready var resolution = $res_control
@onready var fullscreen = $full_screen_control

func _on_back_button_button_down():
	self.queue_free()

func _on_apply_button_button_down():
	SignalBus.change_volume.emit(volume.get_volume())
	var res = resolution.get_resolution()
	res = "{res1} {res2}".format({"res1":res.x,"res2":res.y})
	SignalBus.change_resolution.emit(res)
	SignalBus.change_window_mode.emit(fullscreen.get_screen_mode())
	SignalBus.update_settings.emit()

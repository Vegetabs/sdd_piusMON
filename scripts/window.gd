extends Control

@onready var volume = $volume_control
@onready var resolution = $resolution_text
@onready var fullscreen = $full_screen_control

func _on_back_button_button_down():
	self.queue_free()

func _on_apply_button_button_down():
	SignalBus.change_volume.emit(volume.get_volume())
	SignalBus.change_resolution.emit(resolution.get_resolution)

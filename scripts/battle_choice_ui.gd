extends Control

func _ready():
	SignalBus.send_swaps.connect(swaps_confirmation)

func swaps_confirmation(val:int):
	if val < 3:
		SignalBus.swap.emit("player")
		self.queue_free()

func _on_attack_button_button_down():
	SignalBus.attack.emit("player")
	self.queue_free()

func _on_swap_button_button_down():
	SignalBus.request_swaps.emit("player")

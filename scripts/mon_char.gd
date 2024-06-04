extends CharacterBody2D

@onready var mon_data = []
@onready var mon_sprite = $mon_sprite

func setup_mon(mon_info:Array):
	mon_data = mon_info
	change_mon_texture(1)

func change_mon_texture(mon_id:int) -> void:
	pass

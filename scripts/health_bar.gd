extends Control

@onready var prog_bar = $health_prog
@export var health:int = 0

func _ready():
	prog_bar.value = health

func change_health(val:int) -> void:
	if (health-val) < 0:
		health = 0
	else:
		health -= val
	prog_bar.value = health 

func change_max_health(val:int) -> void:
	health = val
	prog_bar.max_value = val
	prog_bar.value = val

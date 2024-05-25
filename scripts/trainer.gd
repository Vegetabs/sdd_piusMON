extends CharacterBody2D

@onready var anim = $anim_player
@export var team:int

func _ready():
	SignalBus.attack.connect(attack)

func attack(team_id):
	if team_id == team:
		anim.play("trainer_point")

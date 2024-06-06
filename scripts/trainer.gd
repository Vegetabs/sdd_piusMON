extends CharacterBody2D

@onready var anim = $anim_player
@export var team:String

func _ready():
	SignalBus.attack.connect(attack)

func attack(team_name):
	if team_name == team:
		anim.play("trainer_point")

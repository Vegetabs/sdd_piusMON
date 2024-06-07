extends CharacterBody2D

@onready var anim = $anim_player
@export var team:String

func _ready():
	pass

func attack():
	anim.play("trainer_point")

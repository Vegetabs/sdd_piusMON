extends TextureRect

@onready var anim = $logo_animation

func _ready():
	anim.play("sway")

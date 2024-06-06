extends TextureProgressBar

@onready var health:int

func _ready():
	#self.value = health
	pass

func change_health(val:int) -> void:
	if (health-val) < 0:
		health = 0
	else:
		health -= val
	self.value = health 

func change_max_health(val:int) -> void:
	health = val
	self.max_value = val
	self.value = val

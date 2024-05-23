extends LineEdit

@export var loss := 0

func _ready():
	self.text = "Loss - [num]"

func set_loss(val:int) -> void:
	self.text = "Loss - {val}".format({"val":val})

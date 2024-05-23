extends LineEdit

@export var win := 0

func _ready():
	self.text = "Win - [num]"

func set_win(val:int) -> void:
	self.text = "Win - {val}".format({"val":val})

extends LineEdit

@export var ratio:float = 0

func _ready():
	self.text = "Ratio - [num]"

func set_ratio(val:float) -> void:
	self.text = "Ratio - {val}".format({"val":snapped(val,0.01)})

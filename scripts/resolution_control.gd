extends Control

@onready var left_res = $left_res
@onready var right_res = $right_res
@onready var res_text = $res_text
var resolution := 2
var res_arr := [Vector2(1280,720),Vector2(1440,900),Vector2(1920,1080),Vector2(2560,1440)]

func _ready():
	pass

func _update_res_text(val:Vector2):
	res_text.text = "{val1}x{val2}".format({"val1":val.x,"val2":val.y})

func get_resolution() -> Vector2:
	return res_arr[resolution]

func _on_left_res_button_down():
	if resolution-1 >= 0:
		resolution -= 1
		_update_res_text(res_arr[resolution])

func _on_right_res_button_down():
	if resolution+1 < len(res_arr):
		resolution += 1
		_update_res_text(res_arr[resolution])

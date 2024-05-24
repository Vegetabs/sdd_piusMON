extends Control

@onready var health = $health_bar
@onready var swap_1 = $swap_icon1
@onready var swap_2 = $swap_icon2
@onready var swap_3 = $swap_icon3
@onready var swap_arr = [swap_1,swap_2,swap_3]

func _ready():
	remove_swap()

func remove_swap():
	var arr = [swap_1.value,swap_2.value,swap_3.value]
	if _sum_arr(arr) < 3:
		var val = _find_next(arr)
		if val != -1:
			swap_arr[_find_next(arr)].value = 1
		else:
			assert(false,"Error in _find_next(), check params")
	else:
		assert(false,"Can't remove swap, no swaps remaining")

func _find_next(arr:Array) -> int:
	for i in range(len(arr)):
		if i<len(arr)-1 and arr[i+1]==1:
			return i
		elif i==len(arr)-1 and arr[i]==0:
			return i
		else:
			continue
	return -1

#Src: https://godotforums.org/d/22390-does-gdscript-have-a-sum-function
func _sum_arr(arr:Array) -> int:
	var sum := 0
	for i in arr:
		sum += i
	return sum

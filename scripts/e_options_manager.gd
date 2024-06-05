extends VBoxContainer

#@onready var mon_arr = ResourcePaths.get_json_data("mon_data")
@export var num_team := 0
@onready var option1 = $e_option1
@onready var option2 = $e_option2
var mon_team := []

func _ready():
#	var mon_team = _pick_team(num_team)
#	print("\n----initial e team----")
#	print(mon_team)
#	for i in range(num_team):
#		var option = get_child(i)
#		print("mon team i",": ",mon_team[i])
#		if typeof(mon_team[i]["type"]) != 2:
#			print("ERROR!", mon_team[i]["type"])
#		option.update_option(mon_team[i])
	
	pass

func start_selection():
	option1.generate_mon()
	option2.generate_mon()

#func _pick_team(num:int) -> Array:
#	var team = []
#	for i in range(0,num):
#		var rand := randi_range(0,len(mon_arr)-1)
#		print("hasjdhask ",mon_arr[rand])
#		team.append(mon_arr[rand])
#	return team

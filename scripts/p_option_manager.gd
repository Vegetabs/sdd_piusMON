extends VBoxContainer

@onready var mon_arr = ResourcePaths.get_json_data("mon_data")
@export var num_team := 0
var cur_team := []

func _ready():
	SignalBus.accept_team.connect(_check_selection)

#SignalBus.team_confirmed.emit(0,option_txt)

#func _ready():
#	SignalBus.accept_team.connect(_check_selection)
#	var mon_team = _pick_team(num_team)
#	print("----initial mon team----")
#	print(mon_team)
#	for i in range(num_team):
#		var option = get_child(i)
#		print("\n{team}".format({"team":mon_team[i]}))
#		option.update_option(mon_team[i])

func _pick_team(num:int) -> Array:
	var team = []
	for i in range(0,num):
		var rand := randi_range(0,len(mon_arr)-1)
		team.append(mon_arr[rand])
	return team

func option_selected(mon:Array) -> void:
	cur_team.append(mon)

func option_deselected(mon:Array) -> void:
	cur_team.erase(mon)

func _check_selection() -> void:
	print(cur_team)
	print(len(cur_team))
	if len(cur_team) == 2:
		SignalBus.team_confirmed.emit(0,cur_team)

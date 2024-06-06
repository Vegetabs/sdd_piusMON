extends Control

@onready var timer = $Timer
@onready var b_timer = $battle_timer
@onready var start_timer = $initial_timer
@onready var anim = $scene_change_anim
@onready var player_ui = $p_team_battle_ui
@onready var enemy_ui = $e_team_battle_ui
@onready var ui_arr = [player_ui,enemy_ui]
@onready var player_mon = $mon_char
@onready var enemy_mon = $e_mon_char
var p_team := []
var e_team := []
var cur_p := 0
var cur_e := 0
var state_cache := []

var ui_name_dict := {
	"player":player_ui,
	"enemy":enemy_ui
}

func _ready():
	SignalBus.load_team.connect(_load_battle)
	SignalBus.attack.connect(_attack)
	SignalBus.swap.connect(_swap)
	SignalBus.mon_death.connect(_check_death)
	timer.wait_time = 0.25
	timer.start()

func _battle_start() -> void:
	_display_choice_ui()

func _battle_tick(player_choice:String) -> void:
	var ai_choice = _ai_decision(player_choice)
	var speed_check = _speed_check()
	if ai_choice == "attack" and player_choice == "attack":
		if speed_check:
			_attack("player")
			state_cache = ["enemy","attack"]
		else:
			_attack("enemy")
			state_cache = ["player","attack"]
	elif ai_choice == "attack" and player_choice == "swap":
		if speed_check:
			_swap("player")
			state_cache = ["enemy","attack"]
		else:
			_attack("enemy")
			state_cache = ["player","swap"]
	elif ai_choice == "swap" and player_choice == "attack":
		if speed_check:
			_attack("player")
			state_cache = ["enemy","swap"]
		else:
			_swap("enemy")
			state_cache = ["player","attack"]
	elif ai_choice == "swap" and player_choice == "swap":
		if speed_check:
			_swap("player")
			state_cache = ["enemy","swap"]
		else:
			_swap("enemy")
			state_cache = ["player","swap"]
	b_timer.start()

func _ai_decision(player_choice:String) -> String:
	#var confidence := 0
	if (int(e_team[cur_e][2]*_get_type_mult(p_team[cur_p][0],e_team[cur_e][0]))-p_team[cur_p][1][0]) <= 0: #--Check for if enemy will die in next turn--#"
		if (e_team[_swap_cur(cur_e)][2]) > 0:
			return "swap"
		else:
			return "attack"
	else:
		return "attack"

func _speed_check() -> bool:
	if p_team[cur_p][1][1] > e_team[cur_e][1][1]:
		return true
	elif p_team[cur_p][1][1] < e_team[cur_e][1][1]:
		return false
	else:
		return _rand_bool()

func _display_choice_ui() -> void:
	var choice_ui = ScenePaths.str_to_path("battle_choice_ui")
	var inst = load(choice_ui).instantiate()
	add_child(inst)

func _attack(team_name:String) -> void:
	var hit_name = _swap_team_name(team_name)
	var attack_arr = get_team(team_name)[_get_cur(team_name)]
	var hit_arr = get_team(hit_name)[_get_cur(hit_name)]
	var dmg = int(attack_arr[1][0]*_get_type_mult(attack_arr[0],hit_arr[0]))
	_set_arr_health(hit_arr,dmg)
	var attack_mon = _get_mon(team_name)
	attack_mon.attack()
	var hit_mon = _get_mon(_swap_team_name(team_name))
	hit_mon.hit(dmg)

func _get_type_mult(type1:int,type2:int) -> float: #--type1 = attacking, type2 = hit--#
	var type_comp_arr = [[1.0,0.5,2.0],[2.0,1.0,0.5],[0.5,2.0,1.0]] 
	return type_comp_arr[type1-1][type2-1]

func _swap(team_name:String) -> void:
	var ui = _get_ui_node(team_name)
	var cur = _get_cur(team_name)
	ui.set_backup(get_team(team_name)[cur][0])
	cur = _swap_cur(cur)
	var mon = _get_mon(team_name)
	mon.swap(get_team(team_name)[cur])
	
func _load_battle(p_arr:Array,e_arr:Array) -> void:
	#--Array formatted as [id,[stat_arr]]--#
	print(p_arr)
	print(e_arr)
	p_team = _add_cur_health(p_arr)
	e_team = _add_cur_health(e_arr)
	_team_setup("player")
	_team_setup("enemy")

func _team_setup(team_name:String) -> void:
	var arr = get_team(team_name)[_get_cur(team_name)]
	_set_max_health_UI(team_name,arr[1][2])
	_set_backup_UI(team_name,get_team(team_name)[1][0])
	_get_mon(team_name).setup_mon(arr)

func _add_cur_health(arr:Array) -> Array:
	#--Adds life value to end of mon_arr for use as cur_health--#
	for i in arr:
		i.append(i[1][2])
	return arr

func _set_arr_health(arr:Array,val:int) -> void:
	if (arr[2] - val) < 0:
		arr[2] = 0
	else:
		arr[2] -= val

func _set_health_UI(team_name:String,val:int) -> void:
	var ui = _get_ui_node(team_name)
	ui.set_health(val)

func _set_max_health_UI(team_name:String,val:int) -> void:
	var ui = _get_ui_node(team_name)
	ui.set_max_health(val)

func _set_backup_UI(team_name:String,val:int) -> void:
	var ui = _get_ui_node(team_name)
	ui.set_backup(val)

func _remove_swap_UI(team_name:String) -> void:
	var ui = _get_ui_node(team_name)
	ui.remove_swap()

func _get_ui_node(team_name:String):
	match team_name:
		"player":
			return player_ui
		"enemy":
			return enemy_ui
		_:
			assert(false,"Tried to get ui node with invalid name")

func get_team(team_name:String) -> Array:
	var arr := []
	match team_name:
		"player":
			arr = p_team
		"enemy":
			arr = e_team
		_:
			assert(false,"Trying to get team using invalid name")
	return arr

func _get_cur(team_name:String) -> int:
	var val := -1 
	match team_name:
		"player":
			val = cur_p
		"enemy":
			val = cur_e
		_:
			assert(false,"Trying to get team using invalid name")
	return val

func _set_cur(team_name:String,val) -> void:
	match team_name:
		"player":
			cur_p = val
		"enemy":
			cur_e = val
		_:
			assert(false,"Trying to set current mon with invalid team")

func _get_mon(team_name:String):
	match team_name:
		"player":
			return player_mon
		"enemy":
			return enemy_mon
		_:
			assert(false,"Trying to get mon with invalid team_name")

func _swap_cur(cur:int) -> int:
	match cur:
		0:
			cur = 1
		1:
			cur = 0
		_:
			assert(false,"Cur set to invalid value")
	return cur

func _swap_team_name(team_name:String) -> String:
	match team_name:
		"player":
			team_name = "enemy"
		"enemy":
			team_name = "player"
		_:
			assert(false,"Trying to get swapped team names with invalid team name")
	return team_name

func _check_death(team_name:String) -> void:
	var arr = get_team(team_name)
	var cur = _get_cur(team_name)
	cur = _swap_cur(cur)
	if arr[cur][2] > 0:
		_swap(team_name)
	else:
		_battle_end(team_name)

func _rand_bool() -> bool:
	var rand = randi_range(0,1)
	if rand == 0:
		return true
	else:
		return false

func _battle_end(losing_team:String) -> void:
	SignalBus.load_battle_end.emit("losing_team")

func _on_timer_timeout():
	anim.play("backward")
	start_timer.start()

func _on_battle_timer_timeout():
	if state_cache[1] == "attack":
		_attack(state_cache[0])
	elif state_cache[1] == "swap":
		_swap(state_cache[0])
	state_cache = []

func _on_initial_timer_timeout():
	_display_choice_ui()

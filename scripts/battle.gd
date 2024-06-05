extends Control

@onready var player_ui = $p_team_battle_ui
@onready var enemy_ui = $e_team_battle_ui
@onready var ui_arr = [player_ui,enemy_ui]
var p_team := []
var e_team := []
var cur_p := 0
var cur_e := 0

var ui_name_dict := {
	"player":player_ui,
	"enemy":enemy_ui
}

func _ready():
	SignalBus.load_team.connect(_load_battle)
	SignalBus.attack.connect(_attack)
	SignalBus.swap.connect(_swap)

func _attack(team_name:String) -> void:
	pass

func _swap(team_name:String) -> void:
	var ui = _get_ui_node(team_name)
	var cur = _get_cur(team_name)
	ui.set_backup(get_team(team_name)[cur][0])
	match cur:
		0:
			cur = 1
		1:
			cur = 0
		_:
			assert(false,"Cur set to invalid value")

func _load_battle(p_arr:Array,e_arr:Array) -> void:
	#--Array formatted as [id,[stat_arr]]--#
	print(p_arr)
	print(e_arr)
	p_team = p_arr
	e_team = e_arr
	
func _set_health_UI(team_name:String,val:int) -> void:
	var ui = _get_ui_node(team_name)
	ui.set_health(val)

func _set_backup_UI(team_name:String,val:int) -> void:
	var ui = _get_ui_node(team_name)
	ui.set_backup(val)

func _remove_swap_UI(team_name:String) -> void:
	var ui = _get_ui_node(team_name)
	ui.remove_swap()

func _get_ui_node(name:String):
	if name == "player" or name == "enemy":
		return ui_name_dict[name]
	else:
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

extends Control

@onready var player_ui = $p_team_battle_ui
@onready var enemy_ui = $e_team_battle_ui
@onready var ui_arr = [player_ui,enemy_ui]
var p_team := []
var e_team := []

func _ready():
	SignalBus.load_battle.connect(_load_battle)
	
func _load_battle(p_arr:Array,e_arr:Array) -> void:
	p_team = p_arr
	e_team = e_arr
	

func get_team(team_name:String) -> Array:
	var arr := []
	match team_name:
		"p_team":
			arr = p_team
		"e_team":
			arr = e_team
		_:
			assert(false,"Trying to get team using invalid name")
	return arr

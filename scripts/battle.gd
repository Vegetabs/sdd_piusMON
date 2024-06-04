extends Control

@onready var player_ui = $p_team_battle_ui
@onready var enemy_ui = $e_team_battle_ui
@onready var ui_arr = [player_ui,enemy_ui]
var p_team := []
var e_team := []

var ui_name_dict := {
	"player":player_ui,
	"enemy":enemy_ui
}

func _ready():
	SignalBus.load_battle.connect(_load_battle)
	
func _load_battle(p_arr:Array,e_arr:Array) -> void:
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
		"p_team":
			arr = p_team
		"e_team":
			arr = e_team
		_:
			assert(false,"Trying to get team using invalid name")
	return arr

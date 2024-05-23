extends Control

var p_team = []
var e_team = []

func _ready():
	SignalBus.load_battle.connect(_load_battle)
	
func _load_battle(p_team:Array,e_team:Array) -> void:
	self.p_team = p_team
	self.e_team = e_team

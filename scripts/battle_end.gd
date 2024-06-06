extends Control

@onready var losing_team = ""

func _ready():
	SignalBus.send_battle_info.connect(_load_info)

func _load_info(team:String) -> void:
	losing_team = team
	



extends Node

#--Full Scenes--#
@export var startup := "res://scenes/startup.tscn"
@export var main_menu := "res://scenes/main_menu.tscn"
@export var team_selection := "res://scenes/team_selection.tscn"
@export var battle := "res://scenes/battle.tscn"
@export var battle_end := "res://scenes/battle_end.tscn"

#--Window Scenes--#
@export var set_window := "res://scenes/set_window.tscn"
@export var stat_window := "res://scenes/stat_window.tscn"
@export var info_window := "res://scenes/info_window.tscn"
@export var battle_choice_ui := "res://scenes/battle_choice_ui.tscn"

var path_dict := {
	"startup":startup,
	"main_menu":main_menu,
	"team_selection":team_selection,
	"battle":battle,
	"battle_end":battle_end,
	"set_window":set_window,
	"stat_window":stat_window,
	"info_window":info_window,
	"battle_choice_ui":battle_choice_ui
	}

func str_to_path(scene_name):
	return path_dict[scene_name]

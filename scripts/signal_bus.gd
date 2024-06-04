extends Node

#--Signals related to scene transitions--#
signal setup_complete
signal change_scene(next_scene:String)
signal load_scene(scene:String)
signal accept_team
signal load_battle(p_team:Array,e_team:Array)


#--Signals related to settings.gd--#
signal change_resolution
signal change_window_mode
signal change_volume
signal update_settings
signal resolution_changed

#--Signals related to transmitting data--#
signal team_confirmed(team:int,data:Array)
signal load_team(p_team:Array,e_team:Array)
signal change_health_ui(team_name:String)
signal change_backup_ui(team_name:String)
signal change_swap_ui(team_name:String)

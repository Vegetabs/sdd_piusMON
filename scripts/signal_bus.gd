extends Node

#--Signals related to scene transitions--#
signal setup_complete
signal change_scene(next_scene:String)
signal load_scene(scene:String)
signal accept_team
signal load_battle(p_team:Array,e_team:Array)


#--Signals related to settings.gd--#
signal change_resolution(resolution:String)
signal change_window_mode(mode:bool)
signal change_volume(vol:int)
signal update_settings
signal resolution_changed
signal update_real_volume()

#--Signals related to transmitting data--#
signal team_confirmed(team:int,data:Array)
signal load_team(p_team:Array,e_team:Array)
signal load_battle_end(losing_name:String)
signal send_battle_info(losing_name:String)

#--Signals related to the battle scene--#
#--team_name = "player" or "enemy"--#
signal attack(team_name:String)
signal swap(team_name:String)
signal change_health_ui(team_name:String)
signal change_backup_ui(team_name:String)
signal change_swap_ui(team_name:String)
signal mon_death(team_name:String)
signal request_swaps(team_name:String)
signal send_swaps(val:int)

#--Signals related to playing sound effects--#
signal play_hit
signal play_attack

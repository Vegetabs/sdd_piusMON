extends Node

@export var window_mode = false
@export var resolution = Vector2(0,0)
@export var volume = 0
var file_path = "res://data/settings.json"

const window_modes = [
	"fullscreen",
	"windowed"
]

const resolutions = [
	Vector2(2560,1440),
	Vector2(1920,1080),
	Vector2(1440,900),
	Vector2(1280,720)
]

func _ready():
	SignalBus.change_window_mode.connect(_set_window_mode)
	SignalBus.change_resolution.connect(_set_window_resolution)
	SignalBus.change_volume.connect(_set_volume)
	SignalBus.update_settings.connect(_update_settings)

func get_settings() -> Dictionary:
	var data_txt = FileAccess.get_file_as_string(file_path)
	var data_dict = JSON.parse_string(data_txt)
	return data_dict

func get_resolution() -> Vector2:
	return resolution

func get_resolutions() -> Array:
	return resolutions

func get_volume() -> int:
	return volume

func _load_settings() -> void:
	var data_dict = get_settings()
	for i in data_dict:
		match i:
			"window_mode":
				_set_window_mode(int(data_dict[i]))
			"resolution":
				_set_window_resolution(data_dict[i])
			"volume":
				_set_volume(data_dict[i])
			_:
				assert(false,"settings.json contains invalid field")

func _update_settings() -> void:
	var settings = {"window_mode":window_mode,"resolution":resolution,"volume":volume}
	for i in settings:
		_update_settings_file(settings)

func _update_settings_file(settings) -> void:
	var data = JSON.stringify(settings)
	var file = FileAccess.open(file_path,FileAccess.WRITE)
	file.store_string(data)
	file.close()

func _set_window_mode(mode:bool) -> void:
	window_mode = mode
	match mode:
		true: #--Mode = Fullscreen--#
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		false: #--Mode = Windowed--#
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		_: #--Exception--#
			assert(false,"window_mode is set to an invalid value")

func _set_window_resolution(res:String) -> void:
	resolution = _convert_resolution(res)
	get_window().size = resolution
	
func _set_volume(val:int) -> void:
	volume = val

func _convert_resolution(res:String) -> Vector2:
	var res_arr = res.split(" ")
	var vect_res = Vector2(int(res_arr[0]),int(res_arr[1]))
	return vect_res

func start() -> void:
	_load_settings()
	print("load_settings done")
	SignalBus.setup_complete.emit()

#const resolutions = {
#	"2560 1440": Vector2(2560,1440),
#	"1920 1080": Vector2(1920,1080),
#	"1440 900": Vector2(1440,900),
#	"1280 720": Vector2(1280,720)
#}

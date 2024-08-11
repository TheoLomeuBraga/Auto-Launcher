extends Node



var player : RigidBody3D

var is_paused := false


var mouse_sensitivity := 12.0
var joystick_sensitivity := 12.0
var full_screen := false
var language := 0

func set_volume(vol):
	AudioServer.set_bus_volume_db(0,((vol / 100) * 80) - 80)

func get_volume():
	return ((AudioServer.get_bus_volume_db(0) + 80) / 80) * 100

var config_folder_path := OS.get_user_data_dir().path_join("Auto Launcher")
var config_file_path := config_folder_path.path_join("config.cfg")

func save_config():
	var access := DirAccess.open(config_folder_path)
	if access == null:
		DirAccess.make_dir_recursive_absolute(config_folder_path) 
	
	var file := FileAccess.open(config_file_path, FileAccess.ModeFlags.WRITE)
	if file:
		file.store_var(mouse_sensitivity)
		file.store_var(joystick_sensitivity)
		var full_screen_no := 0
		if full_screen:
			full_screen_no = 1
		file.store_var(full_screen_no)
		file.store_var(get_volume())
		file.store_var(language)
		file.close()

func set_language(id):
	if id == null:
		id = 0
	print(id)
	language = id
	if id == 0:
		TranslationServer.set_locale("en_US")
	elif id == 1:
		TranslationServer.set_locale("pt_BR")

func load_config():
	if not FileAccess.file_exists(config_file_path):
		save_config()
		return
	
	var file := FileAccess.open(config_file_path, FileAccess.ModeFlags.READ)
	if file:
		
		var pre_mouse_sensitivity = file.get_var()
		var pre_joystick_sensitivity = file.get_var()
		var pre_full_screen = file.get_var()
		var pre_volume = file.get_var()
		var pre_language = file.get_var()
		
		file.close()
		
		if pre_mouse_sensitivity != null and pre_joystick_sensitivity != null and pre_full_screen != null and pre_volume != null:
			mouse_sensitivity = pre_mouse_sensitivity
			joystick_sensitivity = pre_joystick_sensitivity 
			full_screen = pre_full_screen > 0
			set_volume(pre_volume)
			set_language(pre_language)
			

		else:
			print("error while loading configs")
			save_config()

var sceane_loading = ""
func load_sceane(path : String = sceane_loading) -> void:
	sceane_loading = path
	get_tree().change_scene_to_file("res://menus/loading/loading.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var chalange_time_left := 0.0
func _process(delta):
	chalange_time_left -= delta

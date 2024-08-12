extends Control


func focus():
	Global.load_config()
	$VBoxContainer/MENU_CONTINUE.grab_focus()


func _ready():
	focus()
	$VBoxContainer/MENU_CONTINUE.disabled = Global.load_continue_sceane() == ""
	print("loaded: ",Global.load_continue_sceane())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_menu_continue_pressed():
	Global.load_sceane(Global.load_continue_sceane())

func _on_menu_new_game_pressed():
	Global.load_sceane("res://sceanes/test_level/test_sceane.tscn")

@export var config_menu : PackedScene
var config_menu_instance : Node
func _on_menu_config_pressed():
	config_menu_instance = config_menu.instantiate()
	add_child(config_menu_instance)

func _on_menu_exit_pressed():
	get_tree().quit()







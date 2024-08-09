extends Control

@export var config_menu : PackedScene

func focus():
	Global.load_config()
	$CenterContainer/VBoxContainer/Button.grab_focus()

func _ready():
	focus()


func _process(delta):
	pass


var config_menu_instance : Node

func _on_button_2_pressed():
	config_menu_instance = config_menu.instantiate()
	add_child(config_menu_instance)


func _on_button_3_pressed():
	Global.load_sceane("res://menus/main/main.tscn")
	Global.is_paused = not Global.is_paused
	Engine.time_scale = 1
	

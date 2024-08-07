extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_menu_continue_pressed():
	pass # Replace with function body.

func _on_menu_new_game_pressed():
	get_tree().change_scene_to_file("res://sceanes/test_level/test_sceane.tscn")

var config_menu : PackedScene
func _on_menu_config_pressed():
	pass # Replace with function body.

func _on_menu_exit_pressed():
	get_tree().quit()







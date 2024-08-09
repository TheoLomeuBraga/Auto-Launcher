extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	Global.load_config()
	
	$CenterContainer/VBoxContainer/HSlider.grab_focus()
	
	$CenterContainer/VBoxContainer/HSlider.value = Global.mouse_sensitivity
	$CenterContainer/VBoxContainer/HSlider2.value = Global.joystick_sensitivity
	$CenterContainer/VBoxContainer/HSlider3.value = Global.get_volume()
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		$CenterContainer/VBoxContainer/HBoxContainer/CheckBox.button_pressed = true
	else:
		$CenterContainer/VBoxContainer/HBoxContainer/CheckBox.button_pressed = false
	$CenterContainer/VBoxContainer/OptionButton.select(Global.language)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Global.save_config()
		get_parent().focus()
		queue_free()
		
		
	$CenterContainer/VBoxContainer/HBoxContainer2/Label.text = str(int(Global.mouse_sensitivity))
	$CenterContainer/VBoxContainer/HBoxContainer3/Label.text = str(int(Global.joystick_sensitivity))
	$CenterContainer/VBoxContainer/HBoxContainer4/Label.text = str(int(Global.get_volume()))




func _on_exit_pressed():
	Global.save_config()
	get_parent().focus()
	queue_free()
	


func _on_h_slider_value_changed(value):
	Global.mouse_sensitivity = value


func _on_h_slider_2_value_changed(value):
	Global.joystick_sensitivity = value


func _on_h_slider_3_value_changed(value):
	Global.set_volume(value)


func _on_check_box_toggled(toggled_on):
	Global.full_screen = toggled_on
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)



func _on_option_button_item_selected(index):
	Global.set_language(index)

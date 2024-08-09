extends BasicMovement

@export var gunHand : NodePath
var gunHandNode : Node3D

func reload():
	Global.player = self
	$Camera3D/gun_hand/reverse_cannon.reload(1)

func _ready():
	gunHandNode = get_node(gunHand)
	if gunHandNode != null and  gunHandNode.get_child(0) != null:
		gunHandNode.get_child(0).player = self
		
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func look_around(delta):
	
	
	
	rotation_degrees.y += (mouse_movement.x * delta) + (Input.get_axis("look_right","look_left") * Global.joystick_sensitivity * delta * 90)
	$Camera3D.rotation_degrees.x += (mouse_movement.y * delta) + (Input.get_axis("look_down","look_up") * Global.joystick_sensitivity * delta * 90)
	if $Camera3D.rotation_degrees.x > 90:
		$Camera3D.rotation_degrees.x = 90
	if $Camera3D.rotation_degrees.x < -90:
		$Camera3D.rotation_degrees.x = -90


@export var jump_power := 6.0

var speed_boost_duration := 0.0
func boost_speed_for(seconds):
	speed_boost_duration = seconds

@export var pause_menu : PackedScene
var pause_menu_instance : Node

func pause_unpause():
	Global.is_paused = not Global.is_paused
	if Global.is_paused :
		Engine.time_scale = 0
		pause_menu_instance = pause_menu.instantiate()
		add_child(pause_menu_instance)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Engine.time_scale = 1
		pause_menu_instance.queue_free()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
	

func _process(delta):
	$Camera3D/gun_hand/SubViewportContainer/SubViewport/Camera3D.global_transform = $Camera3D.global_transform
	
	if Input.is_action_just_pressed("pause"):
		if pause_menu_instance == null or  (pause_menu_instance != null and pause_menu_instance.config_menu_instance == null):
			pause_unpause()
		
	

func movement_plugin(delta):
	if gunHandNode != null and  gunHandNode.get_child(0) != null and Input.is_action_just_pressed("shot"):
		gunHandNode.get_child(0).shot()
	
	move_direction = (basis.z.normalized() * Input.get_axis("walk_foward","walk_back")) + (basis.x.normalized() * Input.get_axis("walk_left","walk_right") )
	look_around(delta)
	if in_floor and Input.is_action_just_pressed("jump"):
		jump(jump_power)
	
	if speed_boost_duration > 0:
		speed_boost_duration -= delta
		sliding_time = 1
		speed = 300.0
	else:
		speed = 3.0
	
	$Label.text = "ms: " + str(int(linear_velocity.length()))
	
	

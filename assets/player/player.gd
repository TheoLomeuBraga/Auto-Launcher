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

func look_around(delta):
	
	if Input.is_action_pressed("aim"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
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

func _process(delta):
	$Camera3D/gun_hand/SubViewportContainer/SubViewport/Camera3D.global_transform = $Camera3D.global_transform

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
	
	$VBoxContainer/HBoxContainer/Label.text = "ms: " + str(int(linear_velocity.length()))
	
	

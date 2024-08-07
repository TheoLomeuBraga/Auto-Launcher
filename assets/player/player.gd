extends BasicMovement

@export var gunHand : NodePath
var gunHandNode : Node3D

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



func movement_plugin(delta):
	if gunHandNode != null and  gunHandNode.get_child(0) != null and Input.is_action_just_pressed("shot"):
		gunHandNode.get_child(0).shot()
	
	move_direction = (basis.z.normalized() * Input.get_axis("walk_foward","walk_back")) + (basis.x.normalized() * Input.get_axis("walk_left","walk_right") )
	look_around(delta)
	if in_floor and Input.is_action_just_pressed("jump"):
		jump(jump_power)
	
	$Label.text = "ms: " + str(int(linear_velocity.length()))
	
	

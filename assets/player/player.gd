extends BasicMovement

@export var reverseCannon : NodePath
var reverseCannonNode : Node3D

func _ready():
	reverseCannonNode = get_node(reverseCannon)
	if reverseCannonNode != null:
		reverseCannonNode.player = self

func look_around(delta):
	rotation_degrees.y += (mouse_movement.x * delta) + (Input.get_axis("look_left","ui_right") * Global.joystick_sensitivity * delta)
	$Camera3D.rotation_degrees.x += (mouse_movement.y * delta) + (Input.get_axis("look_up","look_down") * Global.joystick_sensitivity * delta)
	if $Camera3D.rotation_degrees.x > 90:
		$Camera3D.rotation_degrees.x = 90
	if $Camera3D.rotation_degrees.x < -90:
		$Camera3D.rotation_degrees.x = -90

@export var jump_power := 6.0



func movement_plugin(delta):
	if reverseCannonNode != null and Input.is_action_just_pressed("shot"):
		reverseCannonNode.shot()
	
	move_direction = (basis.z.normalized() * Input.get_axis("walk_foward","walk_back")) + (basis.x.normalized() * Input.get_axis("walk_left","walk_right") )
	look_around(delta)
	if in_floor and Input.is_action_just_pressed("jump"):
		jump(jump_power)

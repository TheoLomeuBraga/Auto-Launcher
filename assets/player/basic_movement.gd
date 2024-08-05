extends RigidBody3D
class_name BasicMovement


func _ready():
	pass

var mouse_movement = Vector2.ZERO
func _input(event):
	if event is InputEventMouseMotion:
		mouse_movement = -event.relative * Global.mouse_sensitivity
	else:
		mouse_movement = Vector2.ZERO

func look_around(delta):
	rotation_degrees.y += (mouse_movement.x * delta) + (Input.get_axis("look_left","ui_right") * Global.joystick_sensitivity * delta)
	$Camera3D.rotation_degrees.x += (mouse_movement.y * delta) + (Input.get_axis("look_up","look_down") * Global.joystick_sensitivity * delta)

func _physics_process(delta):
	look_around(delta)


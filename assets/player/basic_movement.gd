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
	if $Camera3D.rotation_degrees.x > 90:
		$Camera3D.rotation_degrees.x = 90
	if $Camera3D.rotation_degrees.x < -90:
		$Camera3D.rotation_degrees.x = -90





var sliding_time := 0.0
var move_direction : Vector3 = Vector3.ZERO


@export var speed := 3.0
@export var jump_power := 6.0



func move(delta):
	move_direction = (basis.z.normalized() * Input.get_axis("walk_foward","walk_back")) + (basis.x.normalized() * Input.get_axis("walk_left","walk_right") )
	
	if move_direction.length() > 0:
		physics_material_override.friction = 0
	else:
		physics_material_override.friction = 10
		
	var in_floor : bool = $floorCheker.is_colliding()
	if in_floor and move_direction != Vector3.ZERO:
		move_direction = move_direction.slide($floorCheker.get_collision_normal(0)).normalized()
	
	move_direction = move_direction.normalized()
	
	if sliding_time > 0:
		var new_velocity = move_direction * speed * 100 * delta
		new_velocity = new_velocity.normalized() * min(new_velocity.length(), speed)
		apply_force(new_velocity)
		physics_material_override.friction = 0
	else:
		var new_velocity = move_direction * speed  * 100 * delta
		new_velocity = new_velocity.normalized() * min(new_velocity.length(), speed)
		linear_velocity.x = new_velocity.x
		linear_velocity.z = new_velocity.z
	
	if in_floor and Input.is_action_just_pressed("jump"):
		apply_impulse(Vector3(0,jump_power,0))
	
	if in_floor:
		sliding_time -= delta

func _physics_process(delta):
	look_around(delta)
	move(delta)


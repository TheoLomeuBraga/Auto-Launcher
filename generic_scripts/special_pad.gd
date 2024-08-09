extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


@export var jump_direction := Vector3.ZERO
@export var jump_redirect = false

@export var speed_boost_duration := 0

func _on_area_3d_body_entered(body):
	if jump_direction != Vector3.ZERO:
		if body.has_method("is_basic_movement"):
			$AudioStreamPlayer3D.play()
			if jump_redirect:
				body.linear_velocity = jump_direction
			else:
				body.linear_velocity += jump_direction
			body.sliding_time = 1
		elif body.has_method("apply_inpulse"):
			body.apply_inpulse(jump_direction * body.mass)
	
	if speed_boost_duration > 0:
		if body.has_method("boost_speed_for"):
			body.boost_speed_for(speed_boost_duration)

extends BaseGun

var player : RigidBody3D

@export var power = 10
@export var max_speed = 50

func shot():
	player.sliding_time = 0.5
	player.linear_velocity = global_basis.x * (min(max_speed,player.linear_velocity.length()) + power)

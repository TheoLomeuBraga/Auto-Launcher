extends BaseGun

var player : RigidBody3D

@export var power := 10
@export var max_speed := 30

var time_next_charge = 0

func reload(no):
	ammon = 1

func _process(delta):
	if player.in_floor:
		time_next_charge -= delta
	
	if player.in_floor and time_next_charge < 0:
		reload(1)
		time_next_charge = 1.0
	
	$GPUParticles3D.visible = ammon > 0
	



var ammon := 1
func shot():
	if ammon > 0:
		player.sliding_time = 0.2
		player.linear_velocity = global_basis.x * (min(max_speed,player.linear_velocity.length()) + power)
		ammon -= 1
		$AudioStreamPlayer.play()
	
	

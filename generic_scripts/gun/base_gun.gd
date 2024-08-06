extends Node3D
class_name BaseGun


@export var bullet : PackedScene

@export var muzle : NodePath

var muzle_node : Node3D

func _gun_ready():
	pass

func _ready():
	muzle_node = get_node(muzle)
	_gun_ready()

func reload():
	pass

func shot():
	if muzle_node != null and bullet != null:
		var b = bullet.instantiate()
		get_tree().get_root().add_child(b)
		b.global_position = muzle_node.global_position
		b.global_rotation = muzle_node.global_rotation

func _gun_process(delta):
	pass
func _process(delta):
	_gun_process(delta)

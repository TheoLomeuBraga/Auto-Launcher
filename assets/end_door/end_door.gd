extends Node3D

@export var open := true
@export var next_sceane = ""

var open_state : float = 0
func _ready():
	if Global.chalange_time_left > 0:
		open_state = 1



func _process(delta):
	if Global.chalange_time_left <= 0:
		open_state -= delta
	else:
		open_state += delta
	open_state = max(0,min(1,open_state))
	$end_door/entity0_brush14.position.z = open_state * 60


func _on_area_3d_body_entered(body):
	if body.has_method("is_basic_movement") and next_sceane != "":
		Global.load_sceane(next_sceane)

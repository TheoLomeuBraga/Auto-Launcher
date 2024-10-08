extends Node3D

var open := true
@export var next_sceane = ""

#door scale 8x8
@export var aways_open : bool = false
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
	if aways_open:
		$end_door/entity0_brush14.position.z = 60


func _on_area_3d_body_entered(body):
	if body.has_method("is_basic_movement") and next_sceane != "":
		Global.load_sceane(next_sceane)
		Global.save_continue_sceane(next_sceane)

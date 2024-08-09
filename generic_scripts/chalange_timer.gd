extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var total_seconds = max(0, Global.chalange_time_left)
	var seconds = int(total_seconds)
	var miliseconsd = (total_seconds - float(seconds)) * 100
	self.text = "%02d:%02d" % [seconds, miliseconsd]

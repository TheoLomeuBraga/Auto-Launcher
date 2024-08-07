extends Area3D




var used := false

func _process(delta):
	$GPUParticles3D.visible = not used
	if Global.player != null and Global.player.in_floor:
		used = false



func _on_body_entered(body):
	if body.has_method("reload") and not used:
		body.reload()
		used = true

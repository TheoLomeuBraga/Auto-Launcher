@tool
extends Area3D


func _ready():
	$MeshInstance3D.visible = Engine.is_editor_hint()




func _on_body_entered(body):
	if not Engine.is_editor_hint():
		if body.has_method("fail"):
			body.fail()

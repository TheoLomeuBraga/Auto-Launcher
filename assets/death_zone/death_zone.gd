
extends Area3D


func _ready():
	#$MeshInstance3D.visible = Engine.is_editor_hint()
	pass




func _on_body_entered(body):
	if body.has_method("fail"):
		body.fail()

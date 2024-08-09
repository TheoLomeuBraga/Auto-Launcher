extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceLoader.load_threaded_request(Global.sceane_loading)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var status = []
	ResourceLoader.load_threaded_get_status(Global.sceane_loading,status)
	$VBoxContainer/ProgressBar.value = status[0]
	if status[0] == 1:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(Global.sceane_loading))

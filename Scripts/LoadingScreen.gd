extends Control

var scene_path = "res://Scenes/Main.tscn"

func _ready():
	ResourceLoader.load_threaded_request(scene_path)

func _process(delta):
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	print(progress[0])
	if progress.size() > 0:
		$ProgressBar.value = progress[0] * 100
	print($ProgressBar.value)
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene = ResourceLoader.load_threaded_get(scene_path)
		get_tree().change_scene_to_packed(scene)

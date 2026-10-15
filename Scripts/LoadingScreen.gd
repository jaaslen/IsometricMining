extends Control

var scene_path = "res://Scenes/Main.tscn"

func _ready():
	ResourceLoader.load_threaded_request(scene_path)
	ResourceLoader.load_threaded_request("res://Scenes/Title.tscn")

func _process(delta):
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(scene_path, progress)

	if progress.size() > 0:
		$ProgressBar.value = progress[0] * 100
		print(progress)

	if status == ResourceLoader.THREAD_LOAD_LOADED:
		Global.AtTitle = false
		var scene = ResourceLoader.load_threaded_get(scene_path)
		get_tree().change_scene_to_packed(scene)


func _on_button_pressed() -> void:
	var scene = ResourceLoader.load_threaded_get(scene_path)
	get_tree().change_scene_to_packed(scene)

	pass # Replace with function body.

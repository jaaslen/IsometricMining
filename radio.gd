extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Credits.text = Music.Music[Music.CurrentSongID][1]
	$Name.text = Music.Music[Music.CurrentSongID][2]
	pass


func _on_back_pressed() -> void:
	Music.Prev()
	pass # Replace with function body.


func _on_forward_pressed() -> void:
	Music.Next()
	pass # Replace with function body.

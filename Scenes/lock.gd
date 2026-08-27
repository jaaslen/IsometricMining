extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	Global.MovedBetween.connect(_on_moved)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_moved(boolean):
	visible = !boolean
	

func _on_detection_lock(boolean) -> void:
	if boolean == true:
		modulate = Color(0,1,0,1)
	else:
		modulate = Color(1,0,0,1)
	pass # Replace with function body.

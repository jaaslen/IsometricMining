extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func MenuOpened():
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func MenuClosed():
	visible = true
	mouse_filter = Control.MOUSE_FILTER_STOP#visible = true

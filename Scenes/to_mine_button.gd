extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.MovedBetween.connect(SurfaceShift)
	pass # Replace with function body.


func SurfaceShift(ToSurface):
	if ToSurface:
		visible = true
	else:
		visible = false
	pass

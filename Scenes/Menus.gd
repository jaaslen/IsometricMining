extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.MovedBetween.connect(SurfaceShift)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func SurfaceShift(ToSurface):
	if ToSurface:
		visible = true
	else:
		visible = false
	pass

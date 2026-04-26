extends CanvasModulate


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LayerChanged.connect(LayerChanged)
	color = Color(Global.Layer["color"])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func LayerChanged(Layer):
	
	color = Color(Layer["color"])
	pass

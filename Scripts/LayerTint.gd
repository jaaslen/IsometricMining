extends CanvasModulate
var PastDepth = true
var time : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LayerChanged.connect(LayerChanged)
	color = Color(Global.Layer["color"])
	pass # Replace with function body.




func LayerChanged(Layer):
	
	color = Color(Layer["color"])
	pass

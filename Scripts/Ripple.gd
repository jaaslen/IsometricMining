extends ColorRect



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LayerChanged.connect(LayerChanged)
	LayerChanged(Global.Layer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func LayerChanged(Layer):
	material.set("shader_parameter/height",Layer["id"]/30.0)
	material.set("shader_parameter/speed",Layer["id"]/3.0)
	pass

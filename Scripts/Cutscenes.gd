extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LayerChanged.connect(LayerChanged)
	pass # Replace with function body.

func LayerChanged(Layer):
	play("LayerTransition")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

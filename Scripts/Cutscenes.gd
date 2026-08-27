extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LayerChanged.connect(LayerChanged)
	pass # Replace with function body.

func LayerChanged(Layer):
	if Layer["id"] != 0:
		play("LayerTransition",-1,8)


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

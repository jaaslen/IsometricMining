extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.DepthChanged.connect(DepthChanged)
	pass # Replace with function body.

func DepthChanged(change):
	
	text = var_to_str(Global.Depth) + "m"
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

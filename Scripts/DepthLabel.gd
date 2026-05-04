extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.DepthChanged.connect(DepthChanged)
	
	DepthChanged(1)
	pass # Replace with function body.

func DepthChanged(_change):
	
	text = var_to_str(Global.Depth) + "m"
	
	pass

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

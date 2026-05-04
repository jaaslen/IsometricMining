extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.DepthChanged.connect(NewLayer)
	NewLayer()
	pass # Replace with function body.



func NewLayer(_Layer = null) -> void:
	$Depth/Amount.text = str(int(Global.Depth)) + "M"
	$MaxDepth/Amount.text = str(int(Global.Stats["DEPTH"])) + "M"
	$Power/Amount.text = "%" + str(int(Global.DepthPower * 100.0))
	pass

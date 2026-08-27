extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.DepthChanged.connect(NewLayer)
	Global.MovedBetween.connect(NewLayer)
	NewLayer()
	pass # Replace with function body.



func NewLayer(_Layer = null) -> void:
	#$Depth/Amount.text = str(int(Global.Depth)) + "M"
	$"Depth Bar".value = Global.Depth
	$"Depth Bar".max_value = int(Global.Stats["DEPTH"])
	$MaxDepth.text = str(int(Global.Stats["DEPTH"])) + "M"
	#$Power/Amount.text = "%" + str(int(Global.DepthPower * 100.0))
	pass

extends Label
var ores = 0
var capacity = Global.InventoryCapacity
signal FullCheck
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.OreChanged.connect(OreChanged)
	OreChanged(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func OreChanged(__):
	ores = 0
	for amount in Global.OreAmounts:
		ores += amount
		
	text = str(ores) + "/" + str(capacity)
	
	if ores >= capacity:
		modulate = Color(1,0,0,1)
		emit_signal("FullCheck",true)
	else:
		emit_signal("FullCheck",false)
		modulate = Color(1,1,1,1)
		
	pass

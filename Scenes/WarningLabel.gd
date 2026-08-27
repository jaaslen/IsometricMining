extends Label
var ores = 0
var capacity = Global.InventoryCapacity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PickaxeChanged.connect(OreChanged)
	Global.OreChanged.connect(OreChanged)
	OreChanged(0,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

	
func OreChanged(__,___ = null):
	
	capacity = Global.InventoryCapacity
	
	ores = 0
	for amount in Global.OreAmounts:
		ores += amount
		

	
	if ores >= capacity:
		visible = true
	else:
		visible = false

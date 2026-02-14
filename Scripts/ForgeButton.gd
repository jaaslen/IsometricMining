extends Button
var PickaxeCost
var PickaxeID
signal PickaxeSelected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func PriceChange(Cost,Buyable,ID) -> void:
	disabled = !Buyable
	PickaxeCost = Cost
	PickaxeID = ID
	
	
	pass # Replace with function body.


func _on_pressed() -> void:
	var Index = 0
	for ore in PickaxeCost:
		
		Global.RemoveOre(PickaxeCost[Index][0],PickaxeCost[Index][1])
		Index += 1
	
	Global.ForgePickaxe(PickaxeID)
	Global.EquipPickaxe(PickaxeID)
	emit_signal("PickaxeSelected",Global.GameData["pickaxes"][var_to_str(PickaxeID)])

	#for i in Global.OreAmounts
	
	pass # Replace with function body.

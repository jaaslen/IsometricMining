extends VBoxContainer
@export var Cost: Array
@export var Buyable: bool = true
signal PriceChange
#var currentpickaxe = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)

	
	pass # Replace with function body.

func PickaxeChanged(PickaxeID):
	
	var Level = Global.GameData["pickaxes"][var_to_str(PickaxeID)]["level"]
	
	var OriginalID = PickaxeID
	if Global.GameData["pickaxes"][var_to_str(PickaxeID)]["unlocked"] == false:
		PickaxeID = 0
	elif Global.GameData["pickaxes"][var_to_str(PickaxeID)]["maxlevel"] == false:
		Cost = Global.GameData["upgrades"][var_to_str(OriginalID * 1000 + (Level+1))]["cost"]
		
		
	
	for i in self.get_children():
		i.queue_free()
		
	
		
	Buyable = true
	for cost in Cost:
		var NewInventoryItem = load("res://CostPanel.tscn").instantiate()
		NewInventoryItem.Ore = Global.GameData["ores"][var_to_str(int(cost["ore"]))]
		NewInventoryItem.Cost = cost["amount"]
		if Global.OreAmounts[int(cost["ore"])] < int(cost["amount"]):
			Buyable = false
			pass
			
		emit_signal("PriceChange",Cost,Buyable,PickaxeID)
			
		#1print(NewInventoryIt em.Pickaxe["color"])#Global.PickaxeInfo["pickaxes"][Index]["color"])
		add_child(NewInventoryItem)
	

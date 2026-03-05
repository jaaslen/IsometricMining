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
	
	
	
	var OriginalID = PickaxeID
	if Global.UnlockedPickaxes[PickaxeID] == false:
		PickaxeID = 0
	else:
		Cost = Global.GameData["pickaxes"][var_to_str(OriginalID)]["cost"]
		
	
	for i in self.get_children():
		i.queue_free()
		
	
		
	Buyable = true
	for cost in Global.GameData["pickaxes"][var_to_str(OriginalID)]["cost"]:
		var NewInventoryItem = load("uid://w4sqtpegcrlw").instantiate()
		NewInventoryItem.Ore = Global.GameData["ores"][var_to_str(int(cost[0]))]
		NewInventoryItem.Cost = cost[1]
		if Global.OreAmounts[int(cost[0])] < int(cost[1]):
			Buyable = false
			pass
			
		emit_signal("PriceChange",Cost,Buyable,PickaxeID)
			
		
		add_child(NewInventoryItem)
	
	

#

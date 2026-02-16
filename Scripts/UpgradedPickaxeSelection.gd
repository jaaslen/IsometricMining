extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)
	PickaxeChanged(1)
	pass # Replace with function body.


func PickaxeChanged(PickaxeID):
	
	for i in self.get_children():
		i.queue_free()
	
	var CurrentLevel = Global.PickaxeLevels[PickaxeID]
	#var print = Global.GameData["pickaxes"][var_to_str(PickaxeID)]["maxlevel"] 
	if Global.GameData["pickaxes"][var_to_str(PickaxeID)]["maxlevel"] > CurrentLevel:
		var NewInventoryItem = load("uid://xok4ed1xpd5x").instantiate()
		#if Global.GameData["pickaxes"][var_to_str(PickaxeID * 1000 + int(CurrentLevel))]["forged"] == false:
		NewInventoryItem.Pickaxe = Global.GameData["pickaxes"][var_to_str((PickaxeID) + 1000 * int(CurrentLevel+1))]
		NewInventoryItem.Forged = false
		NewInventoryItem.disabled = true
		add_child(NewInventoryItem)
	
	pass

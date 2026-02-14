extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)
	PickaxeChanged(1)
	pass # Replace with function body.


func PickaxeChanged(PickaxeID):
	
	for i in self.get_children():
		i.queue_free()
	
	var CurrentLevel = Global.GameData["pickaxes"][var_to_str(PickaxeID)]["level"]
	
	if CurrentLevel > 0:
		if Global.GameData["pickaxes"][var_to_str(PickaxeID)]["maxlevel"] == false:
			var NewInventoryItem = load("uid://xok4ed1xpd5x").instantiate()
			if Global.GameData["upgrades"][var_to_str(PickaxeID * 1000 + int(CurrentLevel))]["forged"] == false:
				NewInventoryItem.Pickaxe = Global.GameData["upgrades"][var_to_str(PickaxeID * 1000 + int(CurrentLevel))]
				NewInventoryItem.disabled = true
			add_child(NewInventoryItem)
	else: 
		if Global.GameData["pickaxes"][var_to_str(PickaxeID)]["maxlevel"] == false:
			var NewInventoryItem = load("uid://xok4ed1xpd5x").instantiate()
			NewInventoryItem.Pickaxe = Global.GameData["pickaxes"][str(PickaxeID)]
			NewInventoryItem.disabled = true
			add_child(NewInventoryItem)
	
	pass

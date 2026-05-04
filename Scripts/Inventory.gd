extends VBoxContainer

var InventoryItem : PackedScene = preload("res://Scenes/InventoryValue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Index = 0
	for amount in Global.OreAmounts:
		
		var NewInventoryItem = InventoryItem.instantiate()
		NewInventoryItem.Ore = Global.GameData["ores"][var_to_str(Index)]
		
		
		if amount == 0:
			NewInventoryItem.visible = false
			
		add_child(NewInventoryItem)
		
		Index += 1



# Called every frame. 'delta' is the elapsed time since the previous frame.

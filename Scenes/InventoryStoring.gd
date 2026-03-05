extends VBoxContainer
@export var LeftSide = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.OreChanged.connect(OreChanged)
	var Index = 0
	for amount in Global.StorageOreAmounts:
		var NewInventoryItem: Node
		if LeftSide:
			NewInventoryItem = load("res://Scenes/InventoryStoring.tscn").instantiate()
			NewInventoryItem.Ore = Global.GameData["ores"][var_to_str(Index)]
			NewInventoryItem.Amount = Global.OreAmounts[Index]
		elif LeftSide == false:
			NewInventoryItem = load("res://Scenes/InventoryStoring.tscn").instantiate()
			NewInventoryItem.Ore = Global.GameData["ores"][var_to_str(Index)]
			NewInventoryItem.Amount = amount
		else:
			push_error("why bro")
			
		NewInventoryItem.MovedOre.connect(OreMoved)
		NewInventoryItem.LeftSide = LeftSide
		
		if amount == 0:
			NewInventoryItem.visible = false
			
		add_child(NewInventoryItem)
		
		Index += 1
	OreChanged(5)

func OreMoved(intostorage,percentagebased,amountvalue,ID):
	var startingamount
	if intostorage:
		startingamount = Global.OreAmounts[ID]
	else:
		startingamount = Global.StorageOreAmounts[ID]
	
	
	if percentagebased == true and amountvalue > 1:
		push_warning("you may have misunderstood the percent value")
	if startingamount == 0:
		push_error("why do you have none how did you do that (inventory storing.gd in storage)")
		return
	
	var amount: int
	if percentagebased:
		amount = floori(startingamount * amountvalue)
	else: 
		amount = amountvalue
	
	Global.StoreOre(ID,amount,intostorage)

func OreChanged(OreID):
	pass
	#print("ok")
	#if LeftSide:
		#if Global.OreAmounts[OreID] == 0:
			#self.get_child(OreID).visible = false
		#else:
			#self.get_child(OreID).visible = true
	#else:
		#if Global.StorageOreAmounts[OreID] == 0:
			#self.get_child(OreID).visible = false
		#else:
			#self.get_child(OreID).visible = true
	#self.get_child(OreID).modulate = Color(1.0, 0.0, 0.0, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.


func MoveEverything() -> void:
	var index = 0
	for amount in Global.OreAmounts:
		Global.StoreOre(index,amount,true)
		index += 1
	pass # Replace with function body.

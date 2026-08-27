extends VBoxContainer
@export var Cost: Array
@export var Buyable: bool = true
signal PriceChange
#var currentpickaxe = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)
	Global.OreChanged.connect(PickaxeUpdated)
	#PickaxeChanged(1)
	#EDIT
	pass # Replace with function body.

func PickaxeChanged(PickaxeID,__ = null):
	
	var CurrentLevel = Global.PickaxeLevels[PickaxeID]
	
	var OriginalID = PickaxeID
	
	if Global.GameData["pickaxes"][str(int(PickaxeID))]["rank"] > Global.Level["id"]:
		PickaxeID = 0
	elif Global.GameData["pickaxes"][var_to_str(int(PickaxeID))]["maxlevel"] > CurrentLevel:
		Cost = Global.GameData["pickaxes"][var_to_str(int(OriginalID) * 1000 + (CurrentLevel+1))]["cost"]
		
		
	
	for i in self.get_children():
		i.queue_free()
		
	
		
	Buyable = true
	for cost in Cost:
		var NewInventoryItem = load("uid://w4sqtpegcrlw").instantiate()
		NewInventoryItem.Ore = Global.GameData["ores"][var_to_str(int(cost[0]))]
		NewInventoryItem.Cost = cost[1]
		if Global.StorageOreAmounts[int(cost[0])] < int(cost[1]):
			Buyable = false
			pass
			
		emit_signal("PriceChange",Cost,Buyable,PickaxeID)
			
	
		add_child(NewInventoryItem)

func PickaxeUpdated(__,___ = null):
	PickaxeChanged(int(Global.Pickaxe["original"]))

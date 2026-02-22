extends VBoxContainer

#var currentpickaxe = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)
	PickaxeChanged(1)
	pass # Replace with function body.

func PickaxeChanged(PickaxeID):
	
	var CurrentLevel = Global.PickaxeLevels[PickaxeID]
	
	
	var OriginalID = PickaxeID
	if Global.UnlockedPickaxes[PickaxeID] == false:
		PickaxeID = 0
	else:
		PickaxeID = 1000 * (CurrentLevel) + PickaxeID
	
	for i in self.get_children():
		i.queue_free()
	var StatIndex = 0
	var stats = Global.GameData["pickaxes"][var_to_str(PickaxeID)]["stats"]
	for stat in Global.GameData["pickaxes"][var_to_str(PickaxeID)]["stats"]:
		if Global.GameData["pickaxes"][var_to_str(OriginalID)]["stats"][StatIndex] == 1 and StatIndex > 1:
			pass
		elif stat != 1 or StatIndex in [0,1]:
			var NewInventoryItem = load("uid://ctx8xrjc65lmv").instantiate()
			NewInventoryItem.Pickaxe = Global.GameData["pickaxes"][var_to_str(PickaxeID)]
			NewInventoryItem.Value = stat #NewInventoryItem.Pickaxe["stats"][stat["stat"]]["value"]
			NewInventoryItem.Stat = StatIndex#Global.StatInfo["stats"][StatIndex]["i"]

			
			add_child(NewInventoryItem)
		StatIndex += 1
	for skill in Global.GameData["pickaxes"][var_to_str(PickaxeID)]["traits"]:
		var NewInventoryItem = load("uid://b04p6hia7y3l0").instantiate()
		NewInventoryItem.Skill = Global.SkillInfo["traits"][skill]
		add_child(NewInventoryItem)
	

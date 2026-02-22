extends VBoxContainer

#var currentpickaxe = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)
	PickaxeChanged(1)
	pass # Replace with function body.

func PickaxeChanged(PickaxeID):


	#var OriginalID = PickaxeID
	if Global.UnlockedPickaxes[PickaxeID] == false:
		PickaxeID = 0
	
	
	for i in self.get_children():
		i.queue_free()
		
	#var CurrentLevel = Global.GameData["pickaxes"][var_to_str(PickaxeID)]["level"]
	
	

	var CurrentLevel = Global.PickaxeLevels[PickaxeID]
	
	if Global.GameData["pickaxes"][var_to_str(PickaxeID)]["maxlevel"] > CurrentLevel:
		
		var UpgradedPickaxe = Global.GameData["pickaxes"][var_to_str(PickaxeID + (1000 * int(CurrentLevel+1)))]
		
		

		print(UpgradedPickaxe["stats"])
		var StatIndex = 0
		for stat in UpgradedPickaxe["stats"]:
			if stat != 1.0 or StatIndex in [0,1]:
				var NewInventoryItem = load("uid://d1pe2igwdtaun").instantiate()
				NewInventoryItem.Stat = StatIndex
				NewInventoryItem.Value = stat
				NewInventoryItem.Pickaxe = UpgradedPickaxe
				add_child(NewInventoryItem)
			StatIndex += 1
				

		
	
	#for stat in Global.GameData["pickaxes"][str(PickaxeID)]["stats"]:
		


	for skill in Global.GameData["pickaxes"][var_to_str(PickaxeID)]["traits"]:
		var NewInventoryItem = load("res://SkillBar.tscn").instantiate()
		NewInventoryItem.Skill = Global.SkillInfo["traits"][skill]
		add_child(NewInventoryItem)
	

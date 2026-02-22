extends GridContainer


func _ready() -> void:
	#Global.OreChanged.connect(AddScenes)
	AddScenes()
	#var Index = 0
	#for amount in range(40):
		#
		#var NewInventoryItem = load("res://OreInfo.tscn").instantiate()
		#NewInventoryItem.Ore = Global.GameData["ores"][var_to_str(Index)]
		#add_child(NewInventoryItem)
		#
		#if amount == 0:
			#NewInventoryItem.visible = false
		#
		#Index += 1

func AddScenes():
	var data = Global.GameData["ores"]
	
	for i in self.get_children():
		i.queue_free()
	
	var keys = data.keys()

	keys.sort_custom(func(a, b):
		return data[a]["sorting"] < data[b]["sorting"]
	)

	for key in keys:
		if data[key]["id"] != 0:
			var scene: PackedScene = load("uid://be6lsgn3ms26")
			var instance = scene.instantiate()
			if Global.FoundOres[data[key]["id"]]:
				instance.Found = true
			instance.Ore = data[key]
			add_child(instance)
			
	%Control.reconnect()

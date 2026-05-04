extends VBoxContainer


func _ready() -> void:
	get_viewport().connect("size_changed", Callable(self, "update_position_and_scale"))
	#Global.OreChanged.connect(AddScenes)
	Global.LayerChanged.connect(ReloadScenes)
	
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
	var data = Global.GameData["layers"]
	
	for i in self.get_children():
		i.queue_free()
	
	var keys = data.keys()



	for key in keys:
		var scene: PackedScene = load("uid://dqlc5y26aavlx")
		var instance = scene.instantiate()
		if int(data[key]["id"]) in Global.FoundLayers:
			instance.Found = true
		instance.Layer = data[key]
		add_child(instance)
			
	%Control.reconnect()
	
func ReloadScenes(__):
	for i in self.get_children():
		i.Check()

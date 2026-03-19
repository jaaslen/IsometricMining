extends GridContainer


func _ready() -> void:
	get_viewport().connect("size_changed", Callable(self, "update_position_and_scale"))
	#Global.OreChanged.connect(AddScenes)
	AddScenes()
	update_position_and_scale()
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
		
func update_position_and_scale():
	columns = floori(get_viewport_rect().size.x / 160)
	#var vp_size = get_viewport_rect().size
	#scale.x = 4 * vp_size.x / reference_resolution.x
	#scale.y = scale.x
	#emit_signal("Scaled")

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

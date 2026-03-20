extends VBoxContainer
signal LoadGraph

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func LoadOre(OreID):

	
	for i in self.get_children():
		if i is PanelContainer:
			i.queue_free()
	var Data = Global.GameData["oredata"]
	
	var index = 0
	for i in Data.values():
		var InfoBarScene = load("uid://6nbcaxdd7tto")
		var InfoBar = InfoBarScene.instantiate()
		InfoBar.Name = i["name"]
		InfoBar.Value = Global.GameData["ores"][str(OreID)]["stats"][index]
		index += 1
		
		add_child(InfoBar)
	
	emit_signal("LoadGraph",ToVector2(Global.GameData["ores"][str(OreID)]["depth"]),Global.GameData["ores"][str(OreID)])
	pass

func ToVector2(arr: Array) -> PackedVector2Array:
	var result := PackedVector2Array()
	
	for pair in arr:
		if pair.size() >= 2:
			result.append(Vector2(pair[0], pair[1]))
	
	return result

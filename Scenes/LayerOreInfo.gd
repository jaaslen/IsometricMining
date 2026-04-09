extends VBoxContainer
#signal LoadGraph
var Ores = Global.GameData["ores"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func LoadLayerOres(LayerID):
	var Layer = Global.GameData["layers"][str(LayerID)]
	
	for i in self.get_children():
		if i is PanelContainer:
			i.queue_free()
	#Ores = Global.GameData["ores"]
	
	var index = 0
	for i in Ores.values():
		var InfoBarScene = load("uid://6nbcaxdd7tto") 
		var InfoBar = InfoBarScene.instantiate()
		InfoBar.Name = i["name"]
		InfoBar.ID = i["id"]
		InfoBar.Value = Global.GetRarity(Layer["start"],index,false)
		InfoBar.modulate = Global.ColourAdjust(Color(i["color"]))
		
		index += 1
		
		if Global.Level["id"] < i["rank"]:
			InfoBar.Name = "???"
			InfoBar.modulate = Color(0.3,0.3,0.3)
		
		if InfoBar.Value > 0:
			add_child(InfoBar)
		
	ReloadLayerOres(Layer["start"])
	#emit_signal("LoadGraph",ToVector2(Global.GameData["ores"][str(OreID)]["depth"]),Global.GameData["ores"][str(OreID)])
	pass

func ToVector2(arr: Array) -> PackedVector2Array:
	var result := PackedVector2Array()
	
	for pair in arr:
		if pair.size() >= 2:
			result.append(Vector2(pair[0], pair[1]))
	
	return result
	
func ReloadLayerOres(Depth):
	var Values = []
	



	for i in get_children():
	
	
		var RarityValue = Global.GetRarity(Depth,i.ID,false)
		
		if RarityValue != 0:
			i.visible = true
		else:
			i.visible = false
		
		
		
		i.Value = RarityValue
		Values.append(i.Value)
		i._ready()
		
		Values.sort()
		#print(Values)
		
	for i in Values:                                 # this might be the worst code ever concieved by someone ever
		for child in get_children():                 # if you are reading this, email jamaslenmail@gmail.com with a better solution
			if i == child.Value:
				move_child(child,0)
		
	#for i in get_children():
		#for val in Values:
			#if val > i.Value:
				#RarityRanking += 1
				#
		#move_child(i,RarityRanking)

		

		
	pass


func _on_h_slider_value_changed(value: float) -> void:
	
	ReloadLayerOres(value)
	
	pass # Replace with function body.

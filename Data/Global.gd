extends Node
signal OreChanged
signal DepthChanged
signal PickaxeChanged
signal LayerChanged


var OresInLayer : Array = [0]
var UsingMouse : bool = true
var XP : int = 0
var Depth : int = 0
var CellSize : Vector2i = Vector2i(32,17)
var TileSize : Vector2i = Vector2i(64,34) 
var TotalOreAmount: int = 3
var TotalStoneAmount : int = 1

var OreAmounts : Array = []
var PickaxeLevels : Array = []
var UnlockedPickaxes : Array = []
var ForgedPickaxes : Array = []
var FoundOres : Array = []

var Tiles : Array = []

var TopLayer : Array = [0,0,0,0,0,0,0,0,0]
var PreviousTopLayer : Array = [0,0,0,0,0,0,0,0,0]
var PickaxeLevel:int = 0

var GameData : Dictionary = LoadJson("res://Data/Data.json")
var SaveData : Dictionary = LoadJson("res://Data/SaveData.json")
#var SkillInfo : Dictionary = LoadJson("res://Data/Data.json")
#var StatInfo : Dictionary = LoadJson("res://Data/Stats.json")
#var GameData : Dictionary = LoadJson("res://Data/OreData.json")
#var GameData : Dictionary = LoadJson("res://Data/PickaxeData.json")
#var GameData : Dictionary = LoadJson("res://Data/UpgradeData.json")

var Pickaxe = GameData["pickaxes"]["1"]
var Layer = GameData["layers"]["0"]

var OresInGame : int = -1
var PickaxesInGame : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Load()
	#GameData = loadjson("res://Data/OreData.json")
	CacheData()
	normalizeores()
	normalizepickaxes()
	AvailableOres()
	
	print(OresInGame)
	print(OreAmounts.size())
	#for v in range(6):
		#var newlayer = []
		#for i in range(9):
			#newlayer.append(GenerateOre())
		##Depth += 1
	Tiles = [[1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1],[1,1,1,1,2,1,1,1,1],[1,1,2,1,3,1,1,1,1],[1,3,1,1,1,3,2,1,1],[1,1,1,3,1,1,1,1,1],[1,1,1,1,1,1,1,2,1]]
	

var OreDepthTables : Dictionary = {}
var OreRarityTable : Dictionary = {}
var PrecomputedRarity : Dictionary = {}

func Save():
	SaveData["inventory"] = OreAmounts
	SaveData["levels"] = PickaxeLevels
	SaveData["unlocked"] = UnlockedPickaxes
	SaveData["found"] = FoundOres
	SaveData["forged"] = ForgedPickaxes
	save_json("res://Data/SaveData.json",SaveData)
	pass

func Load():
	for i in SaveData["inventory"]:
		OreAmounts.append(int(i))
	for i in SaveData["levels"]:
		PickaxeLevels.append(int(i))
	UnlockedPickaxes = SaveData["unlocked"]
	ForgedPickaxes = SaveData["forged"]
	FoundOres = SaveData["found"]

func PrecomputeRarity(max_depth: int):
	for ore_id in OreDepthTables:
		var table = OreDepthTables[ore_id]
		var rarity_map = {}

		for d in range(max_depth + 1):
			rarity_map[d] = GetRarity(d, ore_id)

		PrecomputedRarity[ore_id] = rarity_map


func CacheData():
	for id in GameData["ores"]:
		OreDepthTables[int(id)] = GameData["ores"][id]["depth"]
		OreRarityTable[int(id)] = GameData["ores"][id]["rarity"]


func AvailableOres():
	
	var Available = []
	
	for ore : Dictionary in GameData["ores"].values():
		for layer : int in ore["layer"]:
			if layer == int(Layer["id"]):
				Available.append(ore["id"])
				
	#print(Available)
	OresInLayer = Available
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:


	
	pass
	
func GlobalLayerChange():
	if Depth > Layer["end"]:
		Layer = GameData["layers"][var_to_str(int(Layer["id"]) + 1)]
		AvailableOres()
		emit_signal("LayerChanged",Layer)
		
	
func GlobalMoveDown():
	Depth += 1 

		
	emit_signal("DepthChanged",1)

func LoadJson(path: String) -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open JSON file")
		return {}

	var json = JSON.new()
	var error = json.parse(file.get_as_text())

	if error != OK:
		push_error("JSON parse error")
		return {}

	return json.data

func normalizeores() -> void:
	for Ore in GameData["ores"].values():
		Ore["id"] = int(Ore["id"])
		Ore["sorting"] = int(Ore["sorting"])
		#Ore["hardness"] = int(Ore["hardness"])
		Ore["value"] = int(Ore["value"])
		
		
		
		OresInGame += 1
		
		if OreAmounts.size() < OresInGame:
			OreAmounts.append(0)
		if FoundOres.size() < OresInGame+1:
			FoundOres.append(false)
		

	
func normalizepickaxes():
	for Pickaxes in GameData["pickaxes"].values():
		Pickaxes["id"] = int(Pickaxes["id"])
		#Pickaxes["level"] = int(Pickaxes["level"])
		Pickaxes["original"] = int(Pickaxes["original"])
		PickaxesInGame += 1

		if PickaxeLevels.size() < PickaxesInGame:
			PickaxeLevels.append(0)

func GetRarity(DepthValue: float, OreID: int) -> float:
	
	var DepthTable = OreDepthTables[OreID]#GameData["ores"][var_to_str(OreID)]["depth"]
	
	if DepthTable.size() == 0:
		return 0

	if DepthValue == DepthTable[0][0]:
		return DepthTable[0][1]
	
	if DepthValue < DepthTable[0][0]:
		return 0

	if DepthValue == DepthTable[-1][0]:
		return float(DepthTable[-1][1])
		
	if DepthValue > DepthTable[-1][0]:
		return 0

	# Find the two points to interpolate between
	for i in range(DepthTable.size() - 1):
		var start = DepthTable[i]
		var end = DepthTable[i + 1]

		if DepthValue >= start[0] and DepthValue <= end[0]:
			# Linear interpolation
			var t = (DepthValue - start[0]) / (end[0] - start[0])
			return lerp(float(start[1]), float(end[1]), t)

	# Fallback (should never reach)
	return 0
	
func GenerateOre(DepthChange = 0):
	
	var TotalWeighting = 0
	var OreWeights = []
	for OreID in range(OresInGame):
		var Rarity : float = GetRarity(1 + Depth + 6 + DepthChange,OreID)
		#Global.Pickaxe["stats"][1]["value"]
		if OreRarityTable[OreID] == 0:
			TotalWeighting += Rarity / Global.Pickaxe["stats"][3]
			OreWeights.append(Rarity / Global.Pickaxe["stats"][3])
		elif OreRarityTable[OreID] == 4 or OreRarityTable[OreID] == 5:
			TotalWeighting += Rarity * Global.Pickaxe["stats"][4]
			OreWeights.append(Rarity * Global.Pickaxe["stats"][4])
		else:
			TotalWeighting += Rarity
			OreWeights.append(Rarity)

		

	var randomweighting = TotalWeighting * randf()
	
	var Index = 0
	for weight in OreWeights:
		randomweighting -= weight
		if randomweighting <= 0:
			return Index
		Index += 1
	return Index

func AddOre(OreID,amount = 1):
	OreAmounts[OreID] += amount
	if OreRarityTable[OreID] != 0:
		TotalOreAmount += amount
	else:
		TotalStoneAmount += amount
	
	if Global.FoundOres[OreID] == false:
		Global.FoundOres[OreID] = true
	#save_json("res://Data/Data.json",GameData)
		
	emit_signal("OreChanged",OreID)
	#emit_signal("Pulse",1.025,0.2)
	#emit_signal("Pulse",true)
	
func RemoveOre(OreID,amount = 1):
	OreAmounts[OreID] -= amount
	if GameData["ores"][var_to_str(int(OreID))]["rarity"] != 0:
		TotalOreAmount -= amount
	else:
		TotalStoneAmount -= amount
	emit_signal("OreChanged",OreID)

func GainXP(amount):
	XP += amount * Global.Pickaxe["stats"][2]

func UpgradePickaxe(PickaxeID):
	PickaxeLevels[PickaxeID] += 1
	SelectPickaxe(PickaxeID)
	EquipPickaxe(PickaxeID)
	
	#GameData["pickaxes"] = GameData["upgrades"][var_to_str(PickaxeID * 1000 + int(CurrentLevel+1))]
	#save_json("res://Data/Data.json",GameData)
	return false
	
func ForgePickaxe(PickaxeID):
	ForgedPickaxes[PickaxeID] = true
	emit_signal("PickaxeChanged",PickaxeID)

func save_json(path: String, data) -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		push_error("Failed to open file: " + path)
		return

	file.store_string(JSON.stringify(data, "\t"))
	file.close()
	
func EquipPickaxe(PickaxeID):
	var CurrentLevel = PickaxeLevels[PickaxeID]
	Pickaxe = GameData["pickaxes"][var_to_str(1000 * CurrentLevel + PickaxeID)]
	emit_signal("PickaxeChanged",PickaxeID)
	
func SelectPickaxe(PickaxeID):
	emit_signal("PickaxeChanged",PickaxeID)
	
func _notification(event):
	if event == NOTIFICATION_WM_CLOSE_REQUEST:
		Save()
		get_tree().quit()

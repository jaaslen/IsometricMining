extends Node
signal NewOreFound
signal OreChanged
signal DepthChanged
signal PickaxeChanged
signal LayerChanged
signal LevelUp
signal ExitPromptSelected
signal CameraShake
signal ChangeBG
signal MovedBetween


var DepthPowerCurve : Curve = preload("res://Boosts/DepthPowerCurve.tres")
var BaseScreenSize = Vector2(1920.0,1080.0)

var GameData : Dictionary = LoadJson("res://Data/Data.json")
var SaveData : Dictionary = LoadJson("res://Data/SaveData.json")

var LayerAmount : int = 0
var OresInLayer : Array = [0]
var UsingMouse : bool = true
var Depth : int = 0
var CellSize : Vector2i = Vector2i(32,17)
var TileSize : Vector2i = Vector2i(64,34) 
var TotalOreAmount: int = 3
var TotalStoneAmount : int = 1
var PastDepth : bool = false

var InventoryCapacity:int = 5000
var MaxDepth : int = 0

var OwnedTraits : Array = []
var OreAmounts : Array = []
var StorageOreAmounts : Array = []
var PickaxeLevels : Array = []
#var UnlockedPickaxes : Array = []
var ForgedPickaxes : Array = []
var FoundOres : Array = []
var XP: int = 0
var Level: Dictionary = GameData["levels"]["0"]
var FoundLayers: Array = []
var LevelPoints : int = 0
var Upgrades : Array = []

var Tiles : Array = []

var TopLayer : Array = [0,0,0,0,0,0,0,0,0]
var PreviousTopLayer : Array = [0,0,0,0,0,0,0,0,0]
var PickaxeLevel:int = 0
var DepthPower : float = 1.0

var Stats : Dictionary[String,float] = {
	"POWER" : 1.0,
	"DELAY" : 1.0,
	"XP MULT" : 1.0,
	"LUCK" : 1.0,
	"RARE LUCK" : 1.0
}
#var SkillInfo : Dictionary = LoadJson("res://Data/Data.json")
#var StatInfo : Dictionary = LoadJson("res://Data/Stats.json")
#var GameData : Dictionary = LoadJson("res://Data/OreData.json")
#var GameData : Dictionary = LoadJson("res://Data/PickaxeData.json")
#var GameData : Dictionary = LoadJson("res://Data/UpgradeData.json")

var Pickaxe = GameData["pickaxes"]["1"]
var Layer = GameData["layers"]["0"]

var OresInGame : int = 0
var PickaxesInGame : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Load()
	#GameData = loadjson("res://Data/OreData.json")
	CacheData()
	#GetLevel()
	normalizeores()
	normalizelayers()
	normalizepickaxes()
	AvailableOres()
	SetBaseStats()
	CheckLevelPoints()

		#var newlayer = []
		#for i in range(9):
			#newlayer.append(GenerateOre())
		##Depth += 1
	
	
		
	Tiles = [[1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1],[1,1,1,1,2,1,1,1,1],[1,1,2,1,3,1,1,1,1],[1,3,1,1,1,3,2,1,1],[1,1,1,3,1,1,1,1,1],[1,1,1,1,1,1,1,2,1]]
	emit_signal("LevelUp",GameData["levels"][str(int(Level["id"]))])
	#Music.ChangeSong(Layer["music"],Layer["pitch"])
	NewBG(Layer["bg"],Color(Layer["color"]),Layer["brightness"])

var OreDepthTables : Dictionary = {}
var OreRarityTable : Dictionary = {}
var PrecomputedRarity : Dictionary = {}

#func GetLevel():
	#for level in GameData["levels"].values():
		#if XP >= level["requiredxp"] and XP < level["nextxp"]:
			#Level = level

func Save():
	SaveData["storage"] = StorageOreAmounts
	SaveData["inventory"] = OreAmounts
	SaveData["levels"] = PickaxeLevels
	#SaveData["unlocked"] = UnlockedPickaxes
	SaveData["foundsorted"] = FoundOres
	SaveData["foundlayers"] = FoundLayers
	SaveData["forged"] = ForgedPickaxes
	SaveData["xp"] = XP
	SaveData["level"] = Level["id"]
	SaveData["levelpoints"] = LevelPoints
	SaveData["upgrades"] = Upgrades
	
	save_json("res://Data/SaveData.json",SaveData)
	pass

func FullLayerReset(Amount : int):
	Tiles.clear()
	for i in range(Amount):
		var newlayer = []
		for ore in range(9):
			newlayer.append(GenerateOre(i))
		
		Tiles.append(newlayer)

func ChangeColorTheme(Col : String):
	var Stylebox = load("res://Visuals/MetalPanel.tres")
	var LinePanel = load("res://Visuals/LinePanel.tres")
	var NarrowStyleBox = load("res://Visuals/MetalPanelNarrow.tres")
	Stylebox.modulate_color = Color(Col)
	LinePanel.color = Color(Col)
	NarrowStyleBox.modulate_color = Color(Col)
	
func CheckLevelPoints():
	var SpentPoints : int = 0
	for i in Upgrades:
		SpentPoints += GameData["upgrades"][str(i)]["cost"]
	
	if SpentPoints + LevelPoints != int(Level["id"]) + 1:
		LevelPoints = int(Level["id"]) + 1 - Upgrades.size()
	
func IntArray(FloatArray):
	
	var result: Array

	for i in FloatArray:
		result.append(int(i))
	return result

func Load():
	OreAmounts = IntArray(SaveData["inventory"])
	StorageOreAmounts = IntArray(SaveData["storage"])
	PickaxeLevels = IntArray(SaveData["levels"])
	Upgrades = IntArray(SaveData["upgrades"])
	#UnlockedPickaxes = IntArray(SaveData["unlocked"])
	ForgedPickaxes = IntArray(SaveData["forged"])
	FoundOres = SaveData["foundsorted"]
	XP = SaveData["xp"]
	Level = GameData["levels"][str(int(SaveData["level"]))]
	FoundLayers = IntArray(SaveData["foundlayers"])
	LevelPoints = SaveData["levelpoints"]

func PrecomputeRarity(_max_depth: int):
	pass
	#for ore_id in OreDepthTables:
		#var table = OreDepthTables[ore_id]
		#var rarity_map = {}
#
		#for d in range(max_depth + 1):
			#rarity_map[d] = GetRarity(d, ore_id)
#
		#PrecomputedRarity[ore_id] = rarity_map

func LeveledUp():
	LevelPoints += 1
	emit_signal("LevelUp",Level)
	SetBaseStats()

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
				

	OresInLayer = Available
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func GlobalLayerChange():
	
	for layer in GameData["layers"].values():
		if layer["id"] != Layer["id"]:
			if Depth >= layer["start"] and Depth < layer["end"]:
				Layer = layer#GameData["layers"][var_to_str(int(Layer["id"]) + 1)]
				AvailableOres()
				
				Music.ChangeSong(Layer["music"],Layer["pitch"])
				NewBG(Layer["bg"],Color(Layer["color"]),Layer["brightness"])
				
				if Layer["id"] not in Global.FoundLayers:
					Global.FoundLayers.append(int(Layer["id"]))
					
				emit_signal("LayerChanged",Layer)
				

func GlobalMoveDown():
	Depth += 1 
	if Depth > Stats["DEPTH"]:
		PastDepth = true
	else:
		PastDepth = false
	DepthPower = DepthPowerCurve.sample(min(Depth / Stats["DEPTH"],2))
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
		if StorageOreAmounts.size() < OresInGame:
			StorageOreAmounts.append(0)
		

	
func normalizepickaxes():
	for Pickaxes in GameData["pickaxes"].values():
		Pickaxes["id"] = int(Pickaxes["id"])
		#Pickaxes["level"] = int(Pickaxes["level"])
		Pickaxes["original"] = int(Pickaxes["original"])
		PickaxesInGame += 1

		if PickaxeLevels.size() < PickaxesInGame:
			PickaxeLevels.append(0)
			
func normalizelayers():
	for Layerinfo in GameData["layers"].values():
		
		Layerinfo["id"] = int(Layerinfo["id"])
		LayerAmount += 1

func GetRarity(DepthValue: float, OreID: int, Requirements : bool = true) -> float:
	
	var DepthTable = OreDepthTables[OreID]#GameData["ores"][var_to_str(OreID)]["depth"]
	var LevelRequirement = int(GameData["ores"][var_to_str(OreID)]["rank"])
	
	if int(Level["id"]) < LevelRequirement and Requirements == true:
		return 0
	
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
			
			var AdjustedRarity = Rarity / Stats["LUCK"]
			
			TotalWeighting += AdjustedRarity
			OreWeights.append(AdjustedRarity)
		elif OreRarityTable[OreID] == 4 or OreRarityTable[OreID] == 5:
			
			var AdjustedRarity = Rarity / Stats["RARE LUCK"]
			
			TotalWeighting += AdjustedRarity
			OreWeights.append(AdjustedRarity)
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

func StoreOre(OreID,amount = 1,into = true):
	if into and OreAmounts[OreID] >= amount:
		OreAmounts[OreID] -= amount
		StorageOreAmounts[OreID] += amount
		emit_signal("OreChanged",OreID)
	elif StorageOreAmounts[OreID] >= amount:
		OreAmounts[OreID] += amount
		StorageOreAmounts[OreID] -= amount
		emit_signal("OreChanged",OreID)
	
	
	pass

func AddOre(OreID,Ore,amount = 1):
	OreAmounts[OreID] += amount
	if OreRarityTable[OreID] != 0:
		TotalOreAmount += amount
	else:
		TotalStoneAmount += amount
	
	if Global.FoundOres[Ore["sorting"]] == false:
		Global.FoundOres[Ore["sorting"]] = true
		emit_signal("NewOreFound")
	#save_json("res://Data/Data.json",GameData)
		
	emit_signal("OreChanged",OreID)
	#emit_signal("Pulse",1.025,0.2)
	#emit_signal("Pulse",true)
	
func RemoveOre(OreID,amount = 1):
	StorageOreAmounts[OreID] -= amount
	if GameData["ores"][var_to_str(int(OreID))]["rarity"] != 0:
		TotalOreAmount -= amount
	else:
		TotalStoneAmount -= amount
	emit_signal("OreChanged",OreID)

func GainXP(amount):
	XP += amount * Global.Pickaxe["stats"][2]

func UpgradePickaxe(PickaxeID):
	PickaxeLevels[PickaxeID] += 1
	await SelectPickaxe(PickaxeID)
	EquipPickaxe(PickaxeID)
	
	#GameData["pickaxes"] = GameData["upgrades"][var_to_str(PickaxeID * 1000 + int(CurrentLevel+1))]
	#save_json("res://Data/Data.json",GameData)
	return false
	
func ForgePickaxe(PickaxeID):
	ForgedPickaxes.append(PickaxeID)
	if Depth > Stats["DEPTH"]:
		PastDepth = true
	else:
		PastDepth = false
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
	if Depth > Stats["DEPTH"]:
		PastDepth = true
	else:
		PastDepth = false
	emit_signal("PickaxeChanged",PickaxeID)
	SetBaseStats()
	
func SelectPickaxe(PickaxeID):
	emit_signal("PickaxeChanged",PickaxeID)
	
func _notification(event):
	if event == NOTIFICATION_WM_CLOSE_REQUEST:
		Save()
		get_tree().quit()

func Suffix(value: float,Integer = false) -> String:
	var suffixes = [
		"", "K", "M", "B", "T",
		"Qd", "Qi", "Sx", "Sp",
		"Oc", "No", "Dc", "UDc", 
		"DDc", "TDc", "QdDc", 
		"QiDc", "SxDc", "SpDc", 
		"OcDc", "NoDc", "Vg"
	]
	
	var index = 0
	
	while abs(value) >= 1000.0 and index < suffixes.size() - 1:
		value /= 1000.0
		index += 1
	
	if index >= 1:
		return "%.2f%s" % [value, suffixes[index]]
	elif Integer == false:
		return "%.2f" % value
	elif Integer == true:
		return str(int(value))
	else:
		push_error("What???? (Global, func Suffix())")
		return "bruh"

func IndexFromSorting(SortingID):
	for i in GameData["ores"].values():
		if i["sorting"] == SortingID:
			return i["id"]
			
func ColourAdjust(InitialColor):
	return InitialColor * 0.8 + Color(0.2,0.2,0.2,1)

func Wait(seconds : float):
	var timer = get_tree().create_timer(seconds)
	await timer.timeout
	return

func ShakeCamera(amount):
	emit_signal("CameraShake",amount)
	
func NewBG(id, Colour = Color(1,1,1,1), Brightness = 1):
	emit_signal("ChangeBG",id,Colour,Brightness)
	
func GetStats(OreID : int = -1):
	
	
	var context = MiningContext.new()
	
	context.BaseStats["POWER"] = Pickaxe["stats"][0]
	context.BaseStats["DELAY"] = Pickaxe["stats"][1]
	context.BaseStats["XP MULT"] = Pickaxe["stats"][2]
	context.BaseStats["LUCK"] = Pickaxe["stats"][3]
	context.BaseStats["RARE LUCK"] = Pickaxe["stats"][4]
	context.BaseStats["V. RARE LUCK"] = Pickaxe["stats"][5]
	context.BaseStats["DEPTH"] = Pickaxe["stats"][6]
	context.BaseStats["STORAGE"] = Pickaxe["stats"][7]
	
	for id in Upgrades:
		BoostData.GetUpgrade(id).Apply(OreID,context)
	for id in Pickaxe["traits"]:
		BoostData.GetTrait(id).Apply(OreID,context)
	context.CalculateStats()
	
	
	return context
	
func SetBaseStats():
	var context = MiningContext.new()
	
	context.BaseStats["POWER"] = Pickaxe["stats"][0]
	context.BaseStats["DELAY"] = Pickaxe["stats"][1]
	context.BaseStats["XP MULT"] = Pickaxe["stats"][2]
	context.BaseStats["LUCK"] = Pickaxe["stats"][3]
	context.BaseStats["RARE LUCK"] = Pickaxe["stats"][4]
	context.BaseStats["V. RARE LUCK"] = Pickaxe["stats"][5]
	context.BaseStats["DEPTH"] = Pickaxe["stats"][6]
	context.BaseStats["STORAGE"] = Pickaxe["stats"][7]
	
	for id in Upgrades:
		BoostData.GetUpgrade(id).Apply(-1,context)

	Stats = context.CalculateStats()
	
	MaxDepth = context.DepthGain

	
func GetTime(OreID,Power):
	return Global.GameData["ores"][var_to_str(OreID)]["hardness"] / Power

func MoveBetween(ToSurface: bool):
	if ToSurface:
		Layer = GameData["layers"]["0"]
		Depth = 0
		FullLayerReset(Tiles.size())
		Music.ChangeSong(Layer["music"],Layer["pitch"])
		NewBG(Layer["bg"],Color(Layer["color"]),1)
		
	
	emit_signal("MovedBetween",ToSurface)
	
	pass

extends TextureProgressBar
@onready var Sprite = $Rank/Level
@onready var Tier = $Tier/Level
@onready var TierBox = $Tier
@onready var AmountLabel = $Amount
@onready var RequiredLabel = $Required
@onready var PowerLabel = $Rank/RankPower
@onready var FinalTier = $TierProgress/FinalTier
@onready var TierProgress = $TierProgress
#var level = Global.level
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LevelUp.connect(LevelUI)
	#GetLevel()
	
	value = Global.XP
	
	var level = Global.Level
	
	FinalTier.texture = load("res://Visuals/Ranks/" + str(int(level["TierTotal"])) + ".png")
	PowerLabel.text = "x" + str(level["boost"])
	
	Sprite.texture = load("res://Visuals/Ranks/" + level["name"] + ".png")
	Tier.texture = load("res://Visuals/Ranks/" + str(int(level["Tier"])) + ".png")
	max_value = level["nextxp"]
	self_modulate = Color(level["color"]) 
	$Rank.self_modulate = Color(level["color"]) 
	$Tier.modulate = Color(level["color"]) 
	$Required.modulate  = Color(level["color"]) 
	TierProgress.modulate  = Color(level["color"]) 
	#Tier.self_modulate = Color(level["color"]) 
	
	
	if level["TierTotal"] > level["Tier"]:
		TierProgress.visible = true
		TierProgress.max_value = level["TierTotal"]
		TierProgress.value = level["Tier"]
		TierBox.size.x = 174
	else:
		TierProgress.visible = false
		TierBox.size.x = 140
	
	#max_value = Global.GameData["levels"][str(Global.level)]["nextxp"]
	#Sprite.texture = load("res://Visuals/Ranks/" + Global.GameData["levels"][str(Global.level)]["name"] + ".png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = Global.XP
	AmountLabel.text = Global.Suffix(value,true)
	RequiredLabel.text = Global.Suffix(max_value,true)
	
	if value >= max_value:
		LevelUp()


func LevelUp():
	
	var level = Global.GameData["levels"][str(int(Global.Level["id"]) + 1)]
	
	Global.XP = value - max_value
	#value = Global.XP - max_value
	PowerLabel.text = "x" + str(level["boost"])
	Global.Level = level
	max_value = level["nextxp"]
	Sprite.texture = load("res://Visuals/Ranks/" + level["name"] + ".png")
	Tier.texture = load("res://Visuals/Ranks/" + str(int(level["Tier"])) + ".png")
	Global.LeveledUp()
	
	if level["TierTotal"] > level["Tier"]:
		TierProgress.visible = true
		TierProgress.max_value = level["TierTotal"]
		TierProgress.value = level["Tier"]
		TierBox.size.x = 174
	else:
		TierProgress.visible = false
		TierBox.size.x = 140
	
	pass
	
#func GetLevel():
	#for level in Global.GameData["levels"].values():
		#if Global.XP >= level["requiredxp"] and Global.XP < level["nextxp"]:
			##Global.level = level["id"]
			#Sprite.texture = load("res://Visuals/Ranks/" + level["name"] + ".png")
			#Tier.texture = load("res://Visuals/Ranks/" + str(int(level["Tier"])) + ".png")
			#max_value = level["nextxp"]
			#self_modulate = Color(level["color"]) 
			#$Rank.self_modulate = Color(level["color"]) 
			#$Tier.self_modulate = Color(level["color"]) 
			#Tier.self_modulate = Color(level["color"]) 
			
func LevelUI(level):
	self_modulate = Color(level["color"]) 
	$Rank.self_modulate = Color(level["color"]) 
	$Tier.modulate = Color(level["color"]) 
	$Required.modulate  = Color(level["color"]) 
	TierProgress.modulate  = Color(level["color"]) 
	#Tier.self_modulate = Color(level["color"]) 

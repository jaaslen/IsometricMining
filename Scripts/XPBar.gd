extends Control
@onready var Sprite = $Rank/Level
@onready var Tier = $Tier/Level
@onready var TierBox = $Tier
@onready var AmountLabel = $Amount
@onready var RequiredLabel = $Required
@onready var PowerLabel = $Rank/RankPower
@onready var FinalTier = $TierProgress/FinalTier
@onready var TierProgress = $TierProgress
@onready var Bar = $XPBar
#var level = Global.level
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LevelUp.connect(LevelUI)
	#GetLevel()
	
	Bar.value = Global.XP
	
	var level = Global.Level
	
	FinalTier.texture = load("res://Visuals/Ranks/" + str(int(level["tiertotal"])) + ".png")
	PowerLabel.text = "x" + str(level["boost"])
	
	Sprite.texture = load("res://Visuals/Ranks/" + level["name"] + ".png")
	Tier.texture = load("res://Visuals/Ranks/" + str(int(level["tier"])) + ".png")
	Bar.max_value = level["nextxp"]
	LevelUI(level)
	#self_modulate = Color(level["color"]) 
	#$Rank.self_modulate = Color(level["color"]) 
	#$Tier.modulate = Color(level["color"]) 
	#$Required.modulate  = Color(level["color"]) 
	#TierProgress.modulate  = Color(level["color"]) 
	#Tier.self_modulate = Color(level["color"]) 
	
	
	if level["tiertotal"] > level["tier"]:
		TierProgress.visible = true
		TierProgress.max_value = level["tiertotal"]
		TierProgress.value = level["tier"]
		TierBox.size.x = 174
	else:
		TierProgress.visible = false
		TierBox.size.x = 140
	
	#max_value = Global.GameData["levels"][str(Global.level)]["nextxp"]
	#Sprite.texture = load("res://Visuals/Ranks/" + Global.GameData["levels"][str(Global.level)]["name"] + ".png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Bar.value = Global.XP
	AmountLabel.text = Global.Suffix(Bar.value,true)
	RequiredLabel.text = Global.Suffix(Bar.max_value,true)
	
	if Bar.value >= Bar.max_value:
		LevelUp()


func LevelUp():
	
	var level = Global.GameData["levels"][str(int(Global.Level["id"]) + 1)]
	
	Global.XP = int(Bar.value) - int(Bar.max_value)
	#value = Global.XP - max_value
	PowerLabel.text = "x" + str(level["boost"])
	Global.Level = level
	Bar.max_value = level["nextxp"]
	Sprite.texture = load("res://Visuals/Ranks/" + level["name"] + ".png")
	Tier.texture = load("res://Visuals/Ranks/" + str(int(level["tier"])) + ".png")
	Global.LeveledUp()
	
	if level["tiertotal"] > level["tier"]:
		TierProgress.visible = true
		TierProgress.max_value = level["tiertotal"]
		TierProgress.value = level["tier"]
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
			#Tier.texture = load("res://Visuals/Ranks/" + str(int(level["tier"])) + ".png")
			#max_value = level["nextxp"]
			#self_modulate = Color(level["color"]) 
			#$Rank.self_modulate = Color(level["color"]) 
			#$Tier.self_modulate = Color(level["color"]) 
			#Tier.self_modulate = Color(level["color"]) 
			
func LevelUI(level):
	#self_modulate = Color(level["color"]) 
	$XPBar.self_modulate = Color(level["color"]) 
	$Stats.modulate = Color(level["color"]) 
	$Rank.self_modulate = Color(level["color"]) 
	$Tier.modulate = Color(level["color"]) 
	$Required.modulate  = Color(level["color"]) 
	TierProgress.modulate  = Color(level["color"]) 
	#Tier.self_modulate = Color(level["color"]) 

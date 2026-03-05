extends TextureProgressBar
@onready var Sprite = $Rank/Level
@onready var Tier = $Tier/Level
@onready var AmountLabel = $Amount
@onready var RequiredLabel = $Required
#var Level = Global.Level
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LevelUp.connect(LevelUI)
	#GetLevel()
	
	value = Global.XP

	var level = Global.Level
	Sprite.texture = load("res://Visuals/Ranks/" + level["name"] + ".png")
	Tier.texture = load("res://Visuals/Ranks/" + str(int(level["Tier"])) + ".png")
	max_value = level["nextxp"]
	self_modulate = Color(level["color"]) * 1.8
	$Rank.self_modulate = Color(level["color"]) * 1.8
	$Tier.self_modulate = Color(level["color"]) * 1.8
	Tier.self_modulate = Color(level["color"]) * 1.8
	
	
	#max_value = Global.GameData["levels"][str(Global.Level)]["nextxp"]
	#Sprite.texture = load("res://Visuals/Ranks/" + Global.GameData["levels"][str(Global.Level)]["name"] + ".png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = Global.XP
	AmountLabel.text = str(int(value))
	RequiredLabel.text = str(int(max_value))
	
	if value >= max_value:
		LevelUp()


func LevelUp():
	
	var Level = Global.GameData["levels"][str(int(Global.Level["id"]) + 1)]
	
	Global.XP = value - max_value
	#value = Global.XP - max_value
	
	Global.Level = Level
	max_value = Level["nextxp"]
	Sprite.texture = load("res://Visuals/Ranks/" + Level["name"] + ".png")
	Tier.texture = load("res://Visuals/Ranks/" + str(int(Level["Tier"])) + ".png")
	Global.LeveledUp()
	
	pass
	
#func GetLevel():
	#for level in Global.GameData["levels"].values():
		#if Global.XP >= level["requiredxp"] and Global.XP < level["nextxp"]:
			##Global.Level = level["id"]
			#Sprite.texture = load("res://Visuals/Ranks/" + level["name"] + ".png")
			#Tier.texture = load("res://Visuals/Ranks/" + str(int(level["Tier"])) + ".png")
			#max_value = level["nextxp"]
			#self_modulate = Color(level["color"]) * 1.8
			#$Rank.self_modulate = Color(level["color"]) * 1.8
			#$Tier.self_modulate = Color(level["color"]) * 1.8
			#Tier.self_modulate = Color(level["color"]) * 1.8
			
func LevelUI(level):
	self_modulate = Color(level["color"]) * 1.8
	$Rank.self_modulate = Color(level["color"]) * 1.8
	$Tier.self_modulate = Color(level["color"]) * 1.8
	Tier.self_modulate = Color(level["color"]) * 1.8

extends TextureProgressBar
@onready var Sprite = $Panel/Level
#var Level = Global.Level
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LevelUp.connect(LevelUI)
	GetLevel()
	
	value = Global.XP
	#max_value = Global.GameData["levels"][str(Global.Level)]["nextxp"]
	#Sprite.texture = load("res://Visuals/Ranks/" + Global.GameData["levels"][str(Global.Level)]["name"] + ".png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = Global.XP
	
	
	if value == max_value:
		LevelUp()


func LevelUp():
	
	
	
	
	#value = 0
	#Global.XP = 0
	Global.Level += 1
	max_value = Global.GameData["levels"][str(Global.Level)]["nextxp"]
	Sprite.texture = load("res://Visuals/Ranks/" + Global.GameData["levels"][str(Global.Level)]["name"] + ".png")
	Global.LeveledUp()
	
	pass
	
func GetLevel():
	for level in Global.GameData["levels"].values():
		if Global.XP >= level["requiredxp"] and Global.XP < level["nextxp"]:
			#Global.Level = level["id"]
			Sprite.texture = load("res://Visuals/Ranks/" + level["name"] + ".png")
			max_value = level["nextxp"]
			self_modulate = Color(level["color"]) * 1.8
			$Panel.self_modulate = Color(level["color"]) * 1.8
			
func LevelUI(level):
	self_modulate = Color(level["color"]) * 1.8
	$Panel.self_modulate = Color(level["color"]) * 1.8

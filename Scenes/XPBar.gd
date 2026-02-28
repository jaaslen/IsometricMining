extends ProgressBar
@onready var Sprite = $Sprite2D
var Level = Global.Level
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = Global.XP
	max_value = Global.GameData["levels"][str(Global.Level)]["nextxp"] 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = Global.XP
	
	
	if value == max_value:
		LevelUp()


func LevelUp():
	value = 0
	Global.XP = 0
	Global.Level += 1
	max_value = Global.GameData["levels"][str(Global.Level)]["nextxp"]
	Sprite.texture = load("res://Visuals/Ranks/" + Global.GameData["levels"][str(Global.Level)]["name"] + ".png")
	
	pass

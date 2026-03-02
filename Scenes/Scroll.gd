extends ScrollContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LevelUp.connect(LevelUI)
	LevelUI(Global.GameData["levels"][str(int(Global.Level["id"]))])
	pass # Replace with funuction body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func LevelUI(level):
	self_modulate = Color(level["color"]) * 1.8
	#$Panel.self_modulate = Color(level["color"]) * 1.8

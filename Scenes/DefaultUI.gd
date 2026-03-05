extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LevelUp.connect(LevelUI)
	LevelUI(Global.Level)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func LevelUI(level):
	self.self_modulate = Color(level["color"]) * 1.8

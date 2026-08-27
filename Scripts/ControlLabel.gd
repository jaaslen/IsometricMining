extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = OS.get_keycode_string(GGSSaveManager.load_setting_value(load("res://ggs/game_settings/ChangeMoveInput.tres"))[1])

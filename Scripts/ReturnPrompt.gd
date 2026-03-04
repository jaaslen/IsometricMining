extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func ExitAttempt() -> void:
	visible = true
	pass # Replace with function body.


func _on_no_pressed() -> void:
	Global.emit_signal("ExitPromptSelected",false)
	visible = false
	pass # Replace with function body.


func _on_yes_pressed() -> void:
	Global.emit_signal("ExitPromptSelected",true)
	visible = false
	pass # Replace with function body.

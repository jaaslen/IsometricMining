extends Control
var open : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.





func _on_button_pressed() -> void:
	if !$AnimationPlayer.is_playing():
		open = !open
		if open:
			$AnimationPlayer.play("Open")
		else:
			$AnimationPlayer.play("Close")
	pass # Replace with function body.

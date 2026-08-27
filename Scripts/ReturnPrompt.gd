extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func ExitAttempt() -> void:
	visible = true
	pass # Replace with function body.


func _on_no_pressed() -> void:
	SFX.play_sfx("Metal Hit")
	Global.emit_signal("ExitPromptSelected",false)
	visible = false
	pass # Replace with function body.


func _on_yes_pressed() -> void:
	
	#var index = 0
	#for amount in Global.OreAmounts:
	#	Global.StoreOre(index,amount,true)
	#	index += 1
	Global.emit_signal("ExitPromptSelected",true)
	visible = false
	pass # Replace with function body.

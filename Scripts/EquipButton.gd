extends Button
@export var PickaxeID = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func pressedSFX():
	
	#SFX.play_with_delay("ToggleON","GlassClink",0.1,1,0.5)
	SFX.play_sfx("ToggleON")
	SFX.play_sfx("Glass Clink 3",0.9)
	SFX.play_sfx("Metal Button",0.8)

func _on_pressed() -> void:
	await pressedSFX()
	
	
	#emit_signal("PickaxeSelected",Global.PickaxeInfo["pickaxes"][PickaxeID])

	pass # Replace with function body.


func _on_mouse_entered() -> void:
	SFX.play_sfx("Hover")
	
	pass # Replace with function body.

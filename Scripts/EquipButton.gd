extends Button
@export var PickaxeID = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _on_pressed() -> void:
	Global.EquipPickaxe(PickaxeID)
	#emit_signal("PickaxeSelected",Global.PickaxeInfo["pickaxes"][PickaxeID])

	pass # Replace with function body.

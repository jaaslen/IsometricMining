extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)
	PickaxeChanged(1)
	pass # Replace with function body.


func PickaxeChanged(PickaxeID):
	if Global.ForgedPickaxes[PickaxeID] == true:
		visible = false
	else:
		visible = true
		pass

extends TabContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)
	PickaxeChanged(1)
	pass # Replace with function body.

func PickaxeChanged(PickaxeID):
	
	if Global.GameData["pickaxes"][str(PickaxeID)]["forged"] == false:
		set_tab_disabled(1,true)
		if current_tab == 1:
			select_previous_available()
	else:
		set_tab_disabled(1,false)
# Called every frame. 'delta' is the elapsed time since the previous frame.

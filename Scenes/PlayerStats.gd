extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#for i in Global.Pickaxe["stats"]:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for stat in Global.GameData["stats"].values():
		get_child(stat["id"]).text = " " + stat["name"] + " : " + str(Global.Stats[stat["name"]])
		if Global.Stats[stat["name"]] == 1.0 and stat["id"] not in [0,1]:
			get_child(stat["id"]).text = " ??? : 1.0"
			
		

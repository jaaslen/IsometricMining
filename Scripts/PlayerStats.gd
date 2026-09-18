extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#for i in Global.Pickaxe["stats"]:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for stat in Global.GameData["stats"].values():
		get_child(int(stat["id"])).text = " " + stat["name"] + " : " + str(Global.Stats[stat["name"]])

			
		

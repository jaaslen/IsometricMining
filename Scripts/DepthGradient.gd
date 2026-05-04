extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Layers = Global.GameData["layers"]
	var FinalDepth = Layers[str(Layers.size()-1)]["end"]
	
	var gradient = Gradient.new()
	
	for i in Global.GameData["layers"].values():
	
		gradient.add_point(i["start"] / FinalDepth, Color(i["color"]))
		gradient.interpolation_mode = 1
		texture.gradient = gradient
		
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _on_button_pressed() -> void:
	visible = !visible
	pass # Replace with function body.

func LoadGraph(Data,_OreInfo) -> void:
	$MarginContainer/Chart.set_values(Data)
	#modulate = Color(OreInfo["color"])  / 5 + Color(0.25,0.25,0.25,1)
	
	
	pass # Replace with function body.

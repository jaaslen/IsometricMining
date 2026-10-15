extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func getchances(chances : Array) -> void:
	var index : int = 0
	for i : Panel in self.get_child(0).get_children():
		if chances[index] == 0:
			i.visible = false
		else:
			i.size_flags_stretch_ratio = max(chances[index],3.5)
			i.get_child(1).text = "%d %%" % [chances[index] * 5]
		index += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

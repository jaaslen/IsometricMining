extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(local_to_map(get_local_mouse_position()))
	if self.get_cell_source_id(local_to_map(get_local_mouse_position())) == -1:
		print("-1")
	pass

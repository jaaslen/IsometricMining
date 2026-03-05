extends TextureButton
@export var Pos = Vector2(1772,0) #(1,0) is top right, (0,1) is bottom left (0.5,0.5) is center as you get the idea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_viewport().connect("size_changed", Callable(self, "update_position_and_scale"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_position_and_scale():
	position = Pos - %Camera2D.offset
	

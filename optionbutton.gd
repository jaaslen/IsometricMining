extends Button
@export var selected : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func Selected():
	modulate = Color(0.242, 1.0, 0.0, 1.0)
	selected = true
	
func Deselected():
	modulate = Color(1.0, 0.0, 0.0, 1.0)
	selected = false

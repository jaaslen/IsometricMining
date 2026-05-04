extends CanvasModulate

var time : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.PastDepth:
		time += delta * 2
		var col = (sin(time) / 2) + 0.5
		color.b = col
		color.g = col
		visible = true
	else:
		visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.

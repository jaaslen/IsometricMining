extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.MovedBetween.connect(MovedBetween)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.PastDepth:
		text = "Past Optimal Depth!"
	else:
		text = "%sM" % str(int(Global.Stats["DEPTH"]))

func MovedBetween(boolean):
	visible = !boolean
	text = str(int(Global.Depth)) + "M"

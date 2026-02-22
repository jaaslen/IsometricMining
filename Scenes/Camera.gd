extends Camera2D


func pulse(ok):
	var tween := create_tween()

	zoom = Vector2(1.025, 1.025)

	tween.tween_property(
		self,
		"zoom",
		Vector2.ONE,
		0.2
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
# Called when the node enters the scene tree for the first time.
var bpm := 120.0
var beat_time := 60.0 / bpm

func _ready():
	Global.OreChanged.connect(pulse)
	#var timer = Timer.new()
	#timer.wait_time = beat_time
	#timer.timeout.connect(pulse)
	#add_child(timer)
	#timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Camera2D
var timer : Timer = Timer.new()
var Returning
func Return():
	Returning = true

func toggle(boolean):
	pass
	#if boolean:
		#timer.start()
	#else:
		#timer.stop()

func pulse(size = 1.000,speed = 0.2):
	var tween := create_tween()

	zoom = zoom * size

	tween.tween_property(
		self,
		"zoom",
		Vector2.ONE,
		speed
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
# Called when the node enters the scene tree for the first time.
var bpm := 120.0
var beat_time := 60.0 / bpm

func _ready():
	
	
	timer.wait_time = beat_time
	timer.timeout.connect(pulse)
	add_child(timer)
	#timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Returning:
		zoom = zoom.lerp(Vector2(1,1),0.5)
	pass

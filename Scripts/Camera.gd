extends Camera2D
var timer : Timer = Timer.new()
var Returning

@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).


var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].



func Return():
	Returning = true



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
	Global.CameraShake.connect(AddTrauma)
	
	timer.wait_time = beat_time
	timer.timeout.connect(AddTrauma)
	add_child(timer)
	#timer.start()

func _process(delta):
	#if target:
		#global_position = get_node(target).global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	if Returning:
		zoom = zoom.lerp(Vector2(1,1),0.5)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func AddTrauma(amount):
	trauma = min(trauma + amount, 1.0)


func shake():
	var amount = pow(trauma, 2) / 10
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1) + 5000

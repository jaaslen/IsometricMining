extends Sprite2D

@export var max_rotation := 25.0 # degrees
@export var rotate_speed := 10.0
@export var return_speed := 6.0

var last_mouse_x := 0.0
var target_rotation := 0.0

func _ready():
	last_mouse_x = get_viewport().get_mouse_position().x

func _process(delta):
	position = get_global_mouse_position() + Vector2(0,40)
	var mouse_x = get_viewport().get_mouse_position().x
	var mouse_delta = mouse_x - last_mouse_x
	last_mouse_x = mouse_x

	# Detect mouse movement direction
	if abs(mouse_delta) > 0.1:
		target_rotation = clamp(
			mouse_delta * 0.3,
			-max_rotation,
			max_rotation
		)
	else:
		target_rotation = 0.0

	# Smooth rotation
	rotation_degrees = lerp(
		rotation_degrees,
		target_rotation,
		delta * (rotate_speed if target_rotation != 0 else return_speed)
	)

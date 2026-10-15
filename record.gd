extends TextureRect
var speed : float = 0.0
var maxspeed : float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += speed
	if speed < maxspeed:
		speed = lerp(speed,maxspeed,delta)
	pass
	
func new_song():
	speed = 0

extends Control
var Open = false
var Closing = false
var Opening = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Closing:
		var width = size.x
		size = size.lerp(Vector2(80,40),delta*3)
		if size.distance_squared_to(Vector2(80,40)) < 1:
			size = Vector2(80,40)
			Open = false
			Closing = false
			$Button.text = "v"
	if Opening:
		size = size.lerp(Vector2(333,200),delta*3)
		if size.distance_squared_to(Vector2(333,200)) < 1:
			size = Vector2(333,200)
			Open = true
			Opening = false
			$Button.text = "^"
	pass




func OpenButtonPressed() -> void:
	if Opening:
		Opening = false
		Closing = true
		SFX.play_sfx("Open Panel",0.5)
		
	elif Closing:
		
		Opening = true
		Closing = false
		
		SFX.play_sfx("Open Panel")
		
	else:
		Closing = Open
		Opening = !Open
		


		if !Open:
			SFX.play_sfx("Open Panel")
		else:
			SFX.play_sfx("Open Panel",0.5)
			

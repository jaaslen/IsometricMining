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
		
		size.y = lerpf(size.y,40,delta*5)
		if size.y == 40.0:
			Open = false
			Closing = false
			$Button.text = "v"
	if Opening:
		size.y = lerpf(size.y,240,delta*5)
		if size.y == 240:
			Open = true
			Opening = false
			$Button.text = "^"
	pass




func OpenButtonPressed() -> void:
	if Opening:
		Opening = false
		Closing = true
		SFX.play_sfx("Open Panel",0.6)
		
	elif Closing:
		
		Opening = true
		Closing = false
		
		SFX.play_sfx("Open Panel",0.6)
		
	else:
		Closing = Open
		Opening = !Open
		


		if !Open:
			SFX.play_sfx("Open Panel",0.8,-6)
		else:
			SFX.play_sfx("Open Panel",0.6,-6)
			

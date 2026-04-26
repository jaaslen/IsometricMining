extends Button
var Open = false
var Closing = false
var Opening = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func OpenButtonPressed() -> void:
	if Opening:
		Opening = false
		Closing = true
		emit_signal("MenuClosed")
		
	elif Closing:
		
		Opening = true
		Closing = false
		modulate = Color(1,1,1,1)
		SFX.play_sfx("Open Panel")
		
	else:
		Closing = Open
		Opening = !Open
		
		if Open:
			emit_signal("MenuClosed")
		else:
			
			SFX.play_sfx("Open Panel")
			
			modulate = Color(1,1,1,1)

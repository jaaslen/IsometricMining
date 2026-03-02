extends Control
var Open = false
var Closing = false
var Opening = false
var ClosedPos = Vector2(1900,0)
var OpenPos = Vector2(0,0)
signal MenuOpened
signal MenuClosed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Closing:
		position = position.lerp(ClosedPos,delta * 10)
		if position.distance_squared_to(ClosedPos) < 100:
			position = ClosedPos
			Closing = false
			Open = false
			#emit_signal("MenuClosed")
		
	elif Opening:
		position = position.lerp(OpenPos,delta * 10)
		if position.distance_squared_to(OpenPos) < 100:
			position = OpenPos
			Open = true
			Opening = false
			emit_signal("MenuOpened")
			
			



func OpenButtonPressed() -> void:
	
	if Opening:
		Opening = false
		Closing = true
		emit_signal("MenuClosed")
	elif Closing:
		Opening = true
		Closing = false
		%Control.LoadOre(1,false)
		%GridContainer.AddScenes()
		
	else:
		Closing = Open
		Opening = !Open
		if Open:
			emit_signal("MenuClosed")
		else:
			%Control.LoadOre(1,false)
			%GridContainer.AddScenes()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Forge"):
		OpenButtonPressed()
	pass # Replace with function body.


func OtherButtonPressed() -> void:
	if Open:
		OpenButtonPressed()
	pass # Replace with function body.

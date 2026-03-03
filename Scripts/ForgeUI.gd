extends Control
var Open = false
var Closing = false
var Opening = false
var ClosedPos = Vector2(0,-1080)
var OpenPos = Vector2(0,0)
signal MenuOpened
signal MenuClosed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_viewport().connect("size_changed", Callable(self, "update_position_and_scale"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Closing:
		position = position.lerp(ClosedPos,delta * 10)
		if position.distance_to(ClosedPos) < 10:
			position = ClosedPos
			Closing = false
			Open = false
			
		
	elif Opening:
		position = position.lerp(OpenPos,delta * 10)
		if position.distance_to(OpenPos) < 10:
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
	else:
		Closing = Open
		Opening = !Open
		
		if Open:
			emit_signal("MenuClosed")
		
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Forge"):
		OpenButtonPressed()
	pass # Replace with function body.


func OtherButtonPressed() -> void:
	if Open:
		OpenButtonPressed()
	pass # Replace with function body.

func update_position_and_scale():
	var vp_size = get_viewport_rect().size
	if Open == false and Opening == false and Closing == false:
		position.y = -vp_size.y
	ClosedPos = Vector2(0,-vp_size.y)

extends Button
var Stage : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	
	if Stage == 0:
		Stage = 1
		text = "Are you sure?"
	elif Stage == 1:
		Stage = 2
		text = "Are you REALLY sure?"
	elif Stage == 2:
		Stage = 3
		text = "Are you REALLLLLLLLLY sure?"
	elif Stage == 3:
		Global.ResetData()
		Stage = 0
		text = "RESET DATA"
		
	await Global.Wait(5)
	
	Stage = 0
	text = "RESET DATA"
		
	
	pass # Replace with function body.

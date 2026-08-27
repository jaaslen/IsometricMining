extends Button


func _ready() -> void:
	
	Global.MovedBetween.connect(MovedBetween)
	
	pass # Replace with function body.


	
func MovedBetween(boolean):
	visible = !boolean

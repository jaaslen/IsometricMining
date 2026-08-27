extends SubViewportContainer



func _ready() -> void:
	Global.LayerChanged.connect(LayerChanged)
	Global.MovedBetween.connect(LayerChanged)
	
	pass # Replace with function body.




func LayerChanged(__):
	
	
	pass

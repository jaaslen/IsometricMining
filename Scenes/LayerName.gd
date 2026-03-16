extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.LayerChanged.connect(LayerChanged)
	pass # Replace with function body.

func LayerChanged(Layer):
	#var Layer = Global.GameData["layers"][int(LayerID)]
	text = "[tornado radius=2.0 freq=10.0 connected=0]%s[/tornado]" % Layer["name"]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

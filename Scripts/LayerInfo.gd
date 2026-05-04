extends Control
signal LayerSelected
@export var Layer: Dictionary = Global.GameData["layers"]["0"]
var ActualLayer
@export var Found = false

#@onready var Name = $Container/Text/Name
@onready var Index = $Index
#@onready var #NameLabel = $RichTextLabel
@onready var OpenButton = $Button
# Called when the node enters the scene tree for the first time.n
func _ready() -> void:
	ActualLayer = Layer
	
	$Button.text = Layer["name"]
	
	if Found == false:
		Layer = Global.GameData["layers"]["0"]
		modulate = Color(0.3,0.3,0.3)
		$Button.text = "???"
		$Button.disabled = true
	else:
		
		Index.text = "#" + str(int(Layer["id"]))

		modulate = Layer["color"]
		
		$Button.text = Layer["name"]
		$Button.disabled = false
		
	
	
	pass # Replace with function body.


		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	emit_signal("LayerSelected",int(ActualLayer["id"]))
	pass # Replace with function body.


func _on_button_mouse_entered() -> void:
	SFX.play_sfx("Hover",  (float(Layer["id"]) / float(Global.LayerAmount)) * 0.2 + 0.5 )
	pass # Replace with function body.
	
func Check():
	if int(ActualLayer["id"]) in Global.FoundLayers:
		Found = true
		Layer = ActualLayer
		_ready()
		
	

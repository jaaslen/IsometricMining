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
		
	
	Index.text = "#" + str(int(Layer["id"]))

	OpenButton.modulate = Layer["color"]
	
	#NameLabel.text = Layer["name"]
	#NameLabel.fit_text(#NameLabel,Vector2(140,90))
	
	
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

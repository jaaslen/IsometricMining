extends Control
signal OreSelected
@export var Ore: Dictionary = Global.GameData["ores"]["0"]
var ActualOre
@export var Found = false
@onready var Icon = $MarginContainer/VBoxContainer/TextureRect
@onready var NameLabel = $RichTextLabel
@onready var OpenButton = $Button
# Called when the node enters the scene tree for the first time.n
func _ready() -> void:
	ActualOre = Ore
	if Found == false:
		Ore = Global.GameData["ores"]["0"]
	
	#var buttonbox = OpenButton.get_theme_stylebox("normal").duplicate(true)
	#buttonbox.border_color = Ore["color"]
	#OpenButton.add_theme_stylebox_override("normal",buttonbox)
	OpenButton.modulate = Ore["color"]
	
	NameLabel.text = Ore["name"]
	NameLabel.fit_text(NameLabel,Vector2(140,90))
	var atlas = Ore["atlas"]
	Icon.texture = Icon.texture.duplicate(true)
	Icon.texture.region = Rect2(Vector2(Global.TileSize.x * atlas[0],2 * Global.TileSize.y * atlas[1]),Vector2(Global.TileSize.x,Global.TileSize.y * 2))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	emit_signal("OreSelected",ActualOre["id"])
	pass # Replace with function body.

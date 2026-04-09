extends Control
signal OreSelected
@export var Ore: Dictionary = Global.GameData["ores"]["0"]
var ActualOre
@export var Found = false
@onready var Icon = $MarginContainer/VBoxContainer/TextureRect
#@onready var #NameLabel = $RichTextLabel
@onready var OpenButton = $Button
# Called when the node enters the scene tree for the first time.n
func _ready() -> void:
	ActualOre = Ore
	if Found == false or Ore["rank"] > Global.Level["id"]:
		Ore = Global.GameData["ores"]["0"]
		modulate = Color(0.3,0.3,0.3)
		$Button.disabled = true
	
	#var buttonbox = OpenButton.get_theme_stylebox("normal").duplicate(true)
	#buttonbox.border_color = Ore["color"]
	#OpenButton.add_theme_stylebox_override("normal",buttonbox)
	OpenButton.modulate = Ore["color"]
	
	#NameLabel.text = Ore["name"]
	#NameLabel.fit_text(#NameLabel,Vector2(140,90))
	var atlas = Ore["atlas"]
	Icon.texture = Icon.texture.duplicate(true)
	Icon.texture.region = Rect2(Vector2(Global.TileSize.x * atlas[0],2 * Global.TileSize.y * atlas[1]),Vector2(Global.TileSize.x,Global.TileSize.y * 2))
	pass # Replace with function body.

	if ActualOre["rank"] > Global.Level["id"]:
		$Rank.visible = true
		$Tier.visible = true
		$Tier.modulate = Color(Global.GameData["levels"][str(int(ActualOre["rank"]))]["color"])
		$Rank.texture = load("res://Visuals/Ranks/" + Global.GameData["levels"][str(int(ActualOre["rank"]))]["name"] + ".png")
		$Tier.texture = load("res://Visuals/Ranks/" + str(int(Global.GameData["levels"][str(int(ActualOre["rank"]))]["tier"])) + ".png")
		

	elif ActualOre["rank"] <= Global.Level["id"]:
		$Rank.visible = false
		$Tier.visible = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	emit_signal("OreSelected",ActualOre["id"])
	SFX.play_sfx("ToggleON")
	pass # Replace with function body.


func _on_button_mouse_entered() -> void:
	SFX.play_sfx("Hover",0.6)
	pass # Replace with function body.

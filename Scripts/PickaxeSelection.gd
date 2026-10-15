extends Button
#signal PickaxeSelected
#signal PickaxeListUpdated

@export var Icon : CompressedTexture2D
var Pickaxe: Dictionary = Global.GameData["pickaxes"]["1"]
var Original : Dictionary = Global.GameData["pickaxes"]["1"]

@export var Unlocked: bool
@export var Forged: bool = true

@onready var EquipButton = $Button
@onready var IconBox = self.get_node("Texture")
@onready var LabelBox = self.get_node("Label")
@onready var OreProgressBar = self.get_node("ProgressBar")
@onready var IDLabel = $ID

func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)
	PickaxeChanged(1)
	

	



func _on_pressed() -> void:
	#SFX.play_sfx("Metal Button",0.6)
	var PickaxeID = Pickaxe["original"]
	Global.SelectPickaxe(PickaxeID)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	var PickaxeID = Pickaxe["original"]
	Global.EquipPickaxe(PickaxeID)
	#_ready()
	pass # Replace with function body.

func PickaxeChanged(__):
	IDLabel.self_modulate = Color(Pickaxe["color"])
	EquipButton.modulate = Color(Pickaxe["color"])
	$Selected.modulate = Color(Pickaxe["color"])
	$Status.modulate = Color(Pickaxe["color"])
	IDLabel.text = "#" + str(Original["id"])
	var atlas = Pickaxe["atlas"]
	disabled = false
	#$Texture.texture.region = Rect2(Vector2(Global.TileSize.x * atlas[0],2 * Global.TileSize.y * atlas[1]),Vector2(Global.TileSize.x,Global.TileSize.y * 2))
	custom_minimum_size.x = 480
	EquipButton.visible = false
	EquipButton.disabled = true
	if Pickaxe["rank"] <= Global.Level["id"] and (int(Pickaxe["id"]) % 1000) in Global.ForgedPickaxes and Forged == true:
		EquipButton.visible = true
		EquipButton.disabled = false

		$Status.text = "Forged"
		EquipButton.text = "Equip?"
		$Selected.text = ""
		custom_minimum_size.x = 540
		
		if Global.Pickaxe["id"] == Pickaxe["id"]:
			$Status.text = "Equipped"
			EquipButton.text = "Equipped!"
			
			$Selected.text = "X"
			EquipButton.disabled = true
			
	else:
		EquipButton.visible = false
		$Status.text = "Unlocked"
		
		

	self_modulate = Pickaxe["color"]
	
	LabelBox.self_modulate = Pickaxe["color"]
	#LabelBox.add_theme_color_override("default_color", Color.html(Pickaxe["color"]) * 1.2)
	LabelBox.text = Pickaxe["name"]
	if Original["rank"] > Global.Level["id"]:
		custom_minimum_size.x = 400
		$Status.text = "Not Unlocked"
		disabled = true
		$Rank.visible = true
		$Tier.visible = true
		$Tier.modulate = Color(Global.GameData["levels"][str(int(Original["rank"]))]["color"])
		$Rank.texture = load("res://Visuals/Ranks/" + Global.GameData["levels"][str(int(Original["rank"]))]["name"] + ".png")
		$Tier.texture = load("res://Visuals/Ranks/" + str(int(Global.GameData["levels"][str(int(Original["rank"]))]["tier"])) + ".png")
		
		
		

			
		

	elif Original["rank"] <= Global.Level["id"]:
		$Texture.texture = AtlasTexture.new()
		$Texture.texture.atlas = load("res://Visuals/OreSheet.png")
		$Texture.texture.filter_clip = true
		$Texture.texture.region = Rect2(Vector2(64.0 * atlas[0],68.0 * atlas[1]),Vector2(Global.TileSize.x,Global.TileSize.y * 2.0))
		$Rank.visible = false
		$Tier.visible = false
		



func _on_mouse_entered() -> void:
	SFX.play_sfx("Hover",(float(Pickaxe["id"])/float(Global.PickaxesInGame)) * 0.2 + 0.5 )
	pass # Replace with function body.

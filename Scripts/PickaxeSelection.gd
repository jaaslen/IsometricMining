extends Button
#signal PickaxeSelected
#signal PickaxeListUpdated

@export var Icon : CompressedTexture2D
var Pickaxe: Dictionary = Global.GameData["pickaxes"]["0"]
var Original = Global.GameData["pickaxes"]["0"]

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
	IDLabel.text = "#" + str(Original["id"])
	
	EquipButton.visible = true
	EquipButton.disabled = true
	if Global.UnlockedPickaxes[int(Pickaxe["id"]) % 1000] == true and Global.ForgedPickaxes[int(Pickaxe["id"]) % 1000] == true and Forged == true:
		EquipButton.visible = true
		EquipButton.disabled = false
		custom_minimum_size.y = 180
		EquipButton.text = "Equip?"
		$Selected.text = "☐"
		
		if Global.Pickaxe["id"] == Pickaxe["id"]:
			EquipButton.text = "Equipped!"
			$Selected.text = "🗹"
			EquipButton.disabled = true
			
	else:
		EquipButton.visible = false
		custom_minimum_size.y = 120

	self_modulate = Pickaxe["color"]
	#var Original := get_theme_stylebox("normal")
	#var style := Original.duplicate(true)
	#style.bg_color = Color.html(Pickaxe["color"])  * 0.5
	#style.border_color = Color.html(Pickaxe["color"])  * 1.5
	#add_theme_stylebox_override("normal", style)
	#add_theme_stylebox_override("disabled", style)
	#style.bg_color = style.border_color
	
	#if Global.Pickaxe["id"] == Pickaxe["id"]:
		#Original = get_theme_stylebox("normal")
		#var SelectedStyle = Original.duplicate(true)
		#SelectedStyle.bg_color = get_theme_stylebox("normal").border_color
		#add_theme_stylebox_override("normal", SelectedStyle)
		#
	#
	LabelBox.self_modulate = Pickaxe["color"]
	#LabelBox.add_theme_color_override("default_color", Color.html(Pickaxe["color"]) * 1.2)
	LabelBox.text = Pickaxe["name"]


func _on_mouse_entered() -> void:
	SFX.play_sfx("Hover",(float(Pickaxe["id"])/float(Global.PickaxesInGame)) * 0.2 + 0.5 )
	pass # Replace with function body.

extends Button
#signal PickaxeSelected
#signal PickaxeListUpdated

@export var Icon : CompressedTexture2D
@export var Pickaxe: Dictionary = Global.GameData["pickaxes"]["0"]
@export var Unlocked: bool
@export var Forged: bool

@onready var EquipButton = $Button
@onready var IconBox = self.get_node("Texture")
@onready var LabelBox = self.get_node("Label")
@onready var OreProgressBar = self.get_node("ProgressBar")

func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)
	PickaxeChanged(1)

	



func _on_pressed() -> void:
	var PickaxeID = Pickaxe["id"]
	print(PickaxeID)
	Global.SelectPickaxe(PickaxeID)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	var PickaxeID = Pickaxe["id"]
	Global.EquipPickaxe(PickaxeID)
	#_ready()
	pass # Replace with function body.

func PickaxeChanged(_PickaxeID):
	
	EquipButton.visible = true
	EquipButton.disabled = true
	if Pickaxe["unlocked"] == true and Pickaxe["forged"] == true:
		EquipButton.visible = true
		EquipButton.disabled = false
		EquipButton.text = "Equip?"
		
		if Global.Pickaxe["id"] == Pickaxe["id"]:
			EquipButton.text = "Equipped!"
			print(Pickaxe["name"])
			EquipButton.disabled = true
			
	else:
		EquipButton.visible = false

		
	var Original := get_theme_stylebox("normal")
	var style := Original.duplicate(true)
	style.bg_color = Color.html(Pickaxe["color"])  * 0.5
	style.border_color = Color.html(Pickaxe["color"])  * 1.5
	add_theme_stylebox_override("normal", style)
	add_theme_stylebox_override("disabled", style)
	#style.bg_color = style.border_color
	
	if Global.Pickaxe["id"] == Pickaxe["id"]:
		Original = get_theme_stylebox("normal")
		var SelectedStyle = Original.duplicate(true)
		SelectedStyle.bg_color = get_theme_stylebox("normal").border_color
		add_theme_stylebox_override("normal", SelectedStyle)
		
	
	LabelBox.add_theme_color_override("default_color", Color.html(Pickaxe["color"]) * 1.2)
	LabelBox.text = Pickaxe["name"]

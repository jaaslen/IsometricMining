extends Panel
@export var Icon : CompressedTexture2D
@export var Ore: Dictionary = Global.GameData["ores"]["0"]

@onready var IconBox = self.get_node("Text").get_node("Texture")
@onready var NameLabelBox = self.get_node("Text").get_node("Name")
@onready var AmountLabelBox = self.get_node("Text").get_node("Cost")
@onready var OreProgressBar = self.get_node("ProgressBar")
@onready var Divider = $Text/Divider
var  atlas
var Amount : int = 0
var Name : String
var ID = Ore["id"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Global.OreChanged.connect(OreChanged)
	Name = Ore["name"]
	Amount = Global.OreAmounts[Ore["id"]]
	
	Divider.color = Color(Ore["color"]) * 1.2
	
	NameLabelBox.text = Name # + " " + var_to_str(Amount)
	AmountLabelBox.text = var_to_str(Amount)
	var Original := get_theme_stylebox("panel")
	var style := Original.duplicate(true)
	style.bg_color = Color.html(Ore["color"]) # blue
	add_theme_stylebox_override("panel", style)
	OreProgressBar.max_value = Global.TotalOreAmount
	var newtexture = IconBox.texture.duplicate(true)
	IconBox.texture = newtexture
	atlas = Ore["atlas"]#Global.GameData["ores"][var_to_str(Ore["id"])]["atlas"]
	#LabelOutline(NameLabelBox)
	#LabelOutline(AmountLabelBox)
	OreChanged(int(Ore["id"]))
	pass # Replace with function body.

func OreChanged(OreID):
	
	if OreID == Ore["id"]:
		
		Amount = Global.OreAmounts[Ore["id"]]
		visible = true
		if Amount == 0:
			visible = false

		NameLabelBox.text = Name # + " " + var_to_str(Amount)
		AmountLabelBox.text = var_to_str(Amount)
		
		var Original := get_theme_stylebox("panel")
		var style := Original.duplicate(true)
		style.bg_color = Color(Ore["color"]) * 0.5
		add_theme_stylebox_override("panel", style)
		NameLabelBox.add_theme_color_override("font_color", Color(Ore["color"]) * 1.2)
		AmountLabelBox.add_theme_color_override("font_color", Color(Ore["color"]) * 1.2)
		
		if Ore["rarity"] != 0:
			OreProgressBar.max_value = Global.TotalOreAmount
		else:
			OreProgressBar.max_value = Global.TotalStoneAmount
		
		OreProgressBar.value = Amount

		IconBox.texture.region = Rect2(Vector2(64 * atlas[0],68 * atlas[1]),Vector2(64,68))
		if visible:
			LabelOutline(NameLabelBox)
			#LabelOutline(AmountLabelBox)
		pass
		
func LabelOutline(label):
		var color
		#if label is RichTextLabel:
		color = Color(Ore["color"])#label.get_theme_color("default_color")
		#elif label is Label:
		#	color = label.get_theme_color("font_color")
			
		var brightness = 0.299 * color.r + 0.587 * color.g + 0.114 * color.b
		if brightness < 0.3 and visible:
			
			label.add_theme_color_override("font_outline_color",Color(1.0,1.0,1.0))
			AmountLabelBox.add_theme_color_override("font_outline_color",Color(1.0,1.0,1.0))
		elif visible:
			
			label.add_theme_color_override("font_outline_color",Color(0.0, 0.0, 0.0, 1.0))
			AmountLabelBox.add_theme_color_override("font_outline_color",Color(0.0, 0.0, 0.0, 1.0))
		pass
		

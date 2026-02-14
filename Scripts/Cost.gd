extends PanelContainer
@export var Cost: int = 0
@export var Ore: Dictionary = Global.GameData["ores"]["0"]

@onready var IconBox =  self.get_node("Text").get_node("Texture")
@onready var NameLabelBox = self.get_node("Text").get_node("Name")
@onready var CostLabelBox = self.get_node("Text").get_node("Cost")
@onready var OreProgressBar = self.get_node("ProgressBar")
var ID = int(Ore["id"])

var Name : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	Global.OreChanged.connect(OreChanged)
	Name = Ore["name"]

	#Cost = Global.OreAmounts[ID]
	NameLabelBox.text = Name #+ " : " + var_to_str(Cost)
	
	CostLabelBox.text = var_to_str(Cost) 
	##NameLabelBox.FitText()
	#CostLabelBox.FitText()
	var Original := get_theme_stylebox("panel")
	var style := Original.duplicate(true)
	style.border_color = Color.html(Ore["color"]) * 0.5
	add_theme_stylebox_override("panel", style)
	OreProgressBar.max_value = Cost
	#OreChanged(0)
	pass # Replace with function body.

func OreChanged(OreID):
	pass

#func OreChanged(OreID):
	#print(OreID)
	#print(ID)
	#
	##LabelBox.text = " "+Name + " x " + var_to_str(Cost)
	##var Original := get_theme_stylebox("panel")
	##var style := Original.duplicate(true)
	##style.bg_color = Color(Ore["color"]) * 0.5
	##add_theme_stylebox_override("panel", style)
	#NameLabelBox.modulate = Color(Ore["color"]) * 1.2
	#if Global.OreAmounts[ID] >= Cost: 
		#CostLabelBox.modulate = Color(Ore["color"]) * 1.2
	#else:
		#CostLabelBox.modulate = Color(1.0, 0.0, 0.0, 1.0)
#
	#OreProgressBar.max_value = Cost
	#OreProgressBar.value = Global.OreAmounts[ID] 

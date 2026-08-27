extends PanelContainer
@export var Cost: int = 0
@export var Ore: Dictionary = Global.GameData["ores"]["0"]


@onready var NameLabelBox = self.get_node("Text").get_node("Name")
@onready var CostLabelBox = self.get_node("Text").get_node("Cost")
@onready var OreProgressBar = self.get_node("ProgressBar")
var ID : int
var Name : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ID = int(Ore["id"])
	Name = " " + Ore["name"]

	#Cost = Global.OreAmounts[ID]
	NameLabelBox.text = Name #+ " : " + var_to_str(Cost)
	
	CostLabelBox.text = "%s/%s" % [Global.StorageOreAmounts[ID],Cost]
	##NameLabelBox.FitText()
	#CostLabelBox.FitText()

	OreProgressBar.max_value = Cost
	if Global.StorageOreAmounts[ID] >= Cost: 
		modulate = Color(Ore["color"]) * 0.5 + Color(0.5,0.5,0.5,0.5)
	else:
		modulate = Color(1.0, 0.0, 0.0, 1.0)
	$Text/Divider.modulate = Color(Ore["color"]) * 1.2 + Color(0.2,0.2,0.2,1)
	OreProgressBar.max_value = Cost
	OreProgressBar.value = Global.OreAmounts[ID] 
	pass # Replace with function body.

#func OreChanged(OreID):
	#pass


#func OreChanged(OreID):


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

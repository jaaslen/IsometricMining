extends PanelContainer

@export var Trait: Dictionary = Global.GameData["traits"]["0"]

#@onready var IconBox =  self.get_node("Container").get_node("Text").get_node("Texture")
@onready var LabelBox = self.get_node("Container").get_node("Text").get_node("Name")
#@onready var ValueLabelBox = self.get_node("Container").get_node("Text").get_node("Value")
@onready var Seperation = self.get_node("Container").get_node("Line").get_node("Line")
@onready var Description = self.get_node("Container").get_node("Description")
#@onready var OreProgressBar = self.get_node("Container").get_node("ProgressBar")

var TraitName : String  
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var TraitName = Trait["name"]

	#Global.OreChanged.connect(OreChanged)
	Description.text = Trait["description"]

	#Value = Global.OreAmounts[Trait["id"]]
	LabelBox.text = " " + capitalize_first(TraitName)#+ " : " + ( "%.2f" % Value)

	#CostLabelBox.text = var_to_str(Value) 
	##NameLabelBox.FitText()
	#CostLabelBox.FitText()
	var Original := get_theme_stylebox("panel")
	var style := Original.duplicate(true)
	#style.border_color = Trait["color"]#Color.html(Trait["color"]) * 0.5
	add_theme_stylebox_override("panel", style)

	
	Description.FitText()
	pass # Replace with function body.



	var NodeColor = Color(1,1,1,1)#Color(Trait["color"])


	#var Original := get_theme_stylebox("panel")
	#var style := Original.duplicate(true)
	style.border_color = NodeColor * 0.5
	add_theme_stylebox_override("panel", style)
	#ValueLabelBox.modulate = NodeColor * 1.2
	Seperation.modulate = NodeColor * 1.2
	#LabelBox.modulate = Color(Trait["color"]) * 1.2
	Description.add_theme_color_override("default_color",NodeColor * 1.2)#modulate = NodeColor * 1.2
	
	#if (Value >= Global.Trait[Stat] and Stat != "delay") or (Value <= Global.Trait[Stat] and Stat == "delay"): 
		#Description.modulate = Color(Trait["color"]) * 0.8
		#
	#else:
		#Description.modulate = Color(1.0, 0.0, 0.0, 1.0)
		
		


	#OreProgressBar.max_value = Value
	#OreProgressBar.value = Global.OreAmounts[Trait["id"]] 
	
func capitalize_first(s: String) -> String:
	if s.is_empty():
		return s
	return s.substr(0, 1).to_upper() + s.substr(1)

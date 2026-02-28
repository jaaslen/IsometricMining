extends PanelContainer
@export var Value: float = 0
@export var Pickaxe: Dictionary = Global.GameData["pickaxes"]["0"]
@export var Stat: int = 0
@onready var IconBox =  self.get_node("Container").get_node("Text").get_node("Texture")
@onready var LabelBox = self.get_node("Container").get_node("Text").get_node("Name")
@onready var ValueLabelBox = self.get_node("Container").get_node("Text").get_node("Value")
@onready var Seperation = self.get_node("Container").get_node("Text").get_node("Seperation")

@onready var IncreaseLabelBox = self.get_node("Container").get_node("Text").get_node("Increase")
#@onready var OreProgressBar = self.get_node("Container").get_node("ProgressBar")

var ColorValue:Color
var Name:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if Value >= 0:
		var Increase = (Value - Pickaxe["stats"][Stat])
		Name = capitalize(Global.GameData["stats"][var_to_str(Stat)]["name"])
		ColorValue = Global.GameData["stats"][var_to_str(Stat)]["color"]

		#Global.OreChanged.connect(OreChanged)
		#Value = (Pickaxe["stats"][Stat]["value"])
		#Value = Global.OreAmounts[Pickaxe["id"]]
		LabelBox.text = Name + " "#+ " : " + ( "%.2f" % Value)
		if Value < 10:
			ValueLabelBox.text = " " + ( "%.2f" % Value)
		elif Value < 100:
			ValueLabelBox.text = " " + ( "%.1f" % Value)
		else:
			ValueLabelBox.text = " " + ( "%.0f" % Value)
		#CostLabelBox.text = var_to_str(Value) 
		##NameLabelBox.FitText()
		#CostLabelBox.FitText()
		#var Original := get_theme_stylebox("panel")
		#var style := Original.duplicate(true)
		modulate = ColorValue
		#style.border_color = ColorValue#Color.html(Pickaxe["color"]) * 0.5
		#add_theme_stylebox_override("panel", style)

		

		pass # Replace with function body.



		#ValueLabelBox.modulate = ColorValue * 1.2
		Seperation.modulate = ColorValue * 0.8
		LabelBox.modulate = ColorValue * 1.2
		#IncreaseLabelBox.modulate = ColorValue * 1.2
		IncreaseLabelBox.text = "%.2f" % Global.Pickaxe["stats"][Stat] + "  "
		#if (Increase > 0 and Stat != 1) or (Increase < 0 and Stat == 1): 
			#IncreaseLabelBox.modulate = ColorValue * 1.4
		#elif (Increase == 0):
			#IncreaseLabelBox.modulate = ColorValue * 0.8
		#else:
			#IncreaseLabelBox.modulate = Color(1.0, 0.0, 0.0, 1.0)
			
			
		#if Increase > 0:
			#IncreaseLabelBox.text = "(+" +  "%.2f" % Increase + ")"
		#elif Increase == 0:
			#IncreaseLabelBox.text = "(0)"
		#else:
			#IncreaseLabelBox.text = "(" +  "%.2f" % (Value - Global.Pickaxe["stats"][Stat]) + ")"

	else:
		pass
	#OreProgressBar.max_value = Value
	#OreProgressBar.value = Global.OreAmounts[Pickaxe["id"]] 
func capitalize(text: String) -> String:
	var words = text.split(" ")  # Split string by spaces
	for i in range(words.size()):
		if words[i].length() > 0:
			words[i] = words[i][0].to_upper() + words[i].substr(1)  # Capitalize first letter
	return " ".join(words)  # Join back into a string
#func capitalize_first(s: String) -> String:
	#if s.is_empty():
		#return s
	#return s.substr(0, 1).to_upper() + s.substr(1)
	
func strip_trailing_zeros(value: float) -> String:
	var s := "%.2f" % value   # choose precision you need
	s = s.rstrip("0")
	s = s.rstrip(".")
	return s

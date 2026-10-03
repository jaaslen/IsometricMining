extends PanelContainer
@export var Pickaxe: Dictionary = Global.GameData["pickaxes"]["0"]

#@onready var OreProgressBar = self.get_node("Container").get_node("ProgressBar")

var ColorValue:Color
var Name:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Container/Text/Name.text = Pickaxe["name"]
	modulate = Color(Pickaxe["color"]) * 2 + Color(0.3,0.3,0.3,0)
	
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

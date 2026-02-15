extends Control

var Order = [1,2,3,5,7,6,4,13,14,16,18,22,9,15,8,12,17,32,34,11,10,28,23,20,24,25,27,36,21,26,31,35,38,29,37,33,30,19,39,40]

@export var ActualOre = Global.GameData["ores"]["0"]
@export var Ore = Global.GameData["ores"]["0"]

@onready var PanelStyle = load("uid://bu0qaxonbmuh1")
@onready var Buttons = %GridContainer
@onready var IDlabel = $HBoxContainer/VBoxContainer2/HBoxContainer/Panel3/ID
@onready var Icon = $HBoxContainer/VBoxContainer/Panel/MarginContainer/Icon
@onready var Name = $HBoxContainer/VBoxContainer/Label
@onready var MinDepth = $HBoxContainer/VBoxContainer2/ScrollContainer/VBoxContainer/PanelContainer/Container/Text/MinValue
@onready var MinDescription = $HBoxContainer/VBoxContainer2/ScrollContainer/VBoxContainer/PanelContainer/Container/Description
@onready var MaxDepth = $HBoxContainer/VBoxContainer2/ScrollContainer/VBoxContainer/PanelContainer2/Container/Text/MaxValue
@onready var MaxDescription = $HBoxContainer/VBoxContainer2/ScrollContainer/VBoxContainer/PanelContainer2/Container/Description
@onready var OptimalDepth = $HBoxContainer/VBoxContainer2/ScrollContainer/VBoxContainer/PanelContainer3/Container/Text/OptValue
@onready var OptDescription = $HBoxContainer/VBoxContainer2/ScrollContainer/VBoxContainer/PanelContainer3/Container/Description
@onready var Hardness = $HBoxContainer/VBoxContainer2/ScrollContainer/VBoxContainer/PanelContainer4/Container/Text/Hardness
@onready var HardDescription = $HBoxContainer/VBoxContainer2/ScrollContainer/VBoxContainer/PanelContainer4/Container/Description

@onready var Description = $ScrollContainer/Description

@onready var RareLabel = $HBoxContainer/VBoxContainer2/HBoxContainer/Panel/Rarity
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if Buttons != null:
		#for i in Buttons.get_children():
			#i.OreSelected.connect(LoadOre)
	LoadOre(1)

func reconnect():
	if Buttons != null:
		for i in Buttons.get_children():
			if i.is_connected("OreSelected",LoadOre) == false:
				i.OreSelected.connect(LoadOre)

func LoadOre(OreID,opening = true):
	
	visible = true
	
	Ore = Global.GameData["ores"][var_to_str(OreID)]
	
	
	
	ActualOre = Global.GameData["ores"][var_to_str(OreID)]
	if ActualOre["sorting"] < 10:
		IDlabel.text = "#00" + var_to_str(ActualOre["sorting"])
	elif ActualOre["sorting"] < 100:
		IDlabel.text = "#0" + var_to_str(ActualOre["sorting"])
	else:
		IDlabel.text = "#" + var_to_str(ActualOre["sorting"])
	if Ore["found"] == false:
		Ore = Global.GameData["ores"]["0"]

	PanelStyle.border_color = Color(Ore["color"])  / 5 + Color(0.25,0.25,0.25,1)
	PanelStyle.bg_color = Color(Ore["color"]) / 10 +Color(0.15,0.15,0.15,1)

	var atlas = Ore["atlas"]
	RareLabel.text = ""
	for i in range(ActualOre["rarity"]):
		RareLabel.text += "★"
	for i in range(5-ActualOre["rarity"]):
		RareLabel.text += "☆"
	
	#RareLabel.text = "★"
	Name.text = Ore["name"]
	Name.add_theme_color_override("font_color",Color(Ore["color"]))
	#Name.add_theme_color_override("font_outline_color",Color(Ore["color"]))
	Description.text = Ore["description"]
	Icon.texture = Icon.texture.duplicate(true)
	Icon.texture.region = Rect2(Vector2(Global.TileSize.x * atlas[0],2 * Global.TileSize.y * atlas[1]),Vector2(Global.TileSize.x,Global.TileSize.y * 2))#Rect2(Vector2(Global.TileSize.x * atlas[0],2 * Global.TileSize.y * atlas[1]),Vector2(Global.TileSize.x,Global.TileSize.y * 2))#Rect2(Vector2(64 * atlas[0],68 * atlas[1])*2,Vector2(64,68)*2)
	
	if Ore["id"] == 0:
		MinDepth.text = "%sm" % int(ActualOre["arrival"])
		MaxDepth.text = "???m"
		Hardness.text = "???"
		OptimalDepth.text = "???m"
		OptimalDepth.add_theme_font_size_override("font_size",50)
	else:
	
		MinDepth.text = "%sm" % int(Ore["arrival"])
		MaxDepth.text = "%sm" % int(Ore["depth"][-1][0])
		Hardness.text = "%s" % int(Ore["hardness"])
		if Ore["optimal"].size() == 2:
			OptimalDepth.text = "%s-%sm " % [int(Ore["optimal"][0]),int(Ore["optimal"][1])]
			OptDescription.text = "This ore is most common at a depth of [color=white]%s[/color]-[color=white]%s[/color]m." % [int(Ore["optimal"][0]),int(Ore["optimal"][1])]
			OptimalDepth.add_theme_font_size_override("font_size",40)
		else:
			OptimalDepth.text = "%sm" % int(Ore["optimal"][0])
			OptDescription.text = "This ore is most common at a depth of [color=white]%d[/color]m." % int(Ore["optimal"][0])
			OptimalDepth.add_theme_font_size_override("font_size",50)
			
	MinDescription.text = "This ore first starts appearing at a depth of [color=white]%d[/color]m." % int(Ore["arrival"])
	MaxDescription.text = "This ore will stop appearing past a depth of [color=white]%d[/color]m." % int(Ore["depth"][-1][0])
	HardDescription.text = "This ore has a toughness of %s, this is %sx as tough as stone. " % [int(Ore["hardness"]),int(Ore["hardness"])/2]
	
		
	if opening:
		ButtonPressed()


var Open = true
var Closing = false
var Opening = false
var ClosedPos = Vector2(1920,0)
var OpenPos = Vector2(0,0)
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Closing:
		position = position.lerp(ClosedPos,delta * 10)
		if position.distance_to(ClosedPos) < 10:
			position = ClosedPos
			Closing = false
			Open = false
		
	elif Opening:
		position = position.lerp(OpenPos,delta * 10)
		if position.distance_to(OpenPos) < 10:
			position = OpenPos
			Open = true
			Opening = false
			



func ButtonPressed() -> void:
	if Opening:
		Opening = false
		Closing = true
	elif Closing:
		Opening = true
		Closing = false
	else:
		Closing = Open
		Opening = !Open
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Forge"):
		ButtonPressed()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	ButtonPressed()
	pass # Replace with function body.


func LeftPress() -> void:
	if ActualOre["sorting"] > (1):
		var nextid
		for i in Global.GameData["ores"].values():
			if i["sorting"] == ActualOre["sorting"] - 1:
				nextid = i["id"]
				print(nextid)
		print(nextid)
		LoadOre(nextid,false)
	else:
		var nextid
		for i in Global.GameData["ores"].values():
			if i["sorting"] == Global.OresInGame:
				nextid = i["id"]
		if nextid != null:
			LoadOre(nextid,false)
		else:
			LoadOre(1,false)
		#LoadOre(nextid,false)
	pass # Replace with function body.


func RightPress() -> void:
	if ActualOre["sorting"] < (Global.OresInGame):
		var nextid
		for i in Global.GameData["ores"].values():
			if i["sorting"] == ActualOre["sorting"] + 1:
				nextid = i["id"]
				print(nextid)
		if nextid != null:
			LoadOre(nextid,false)
		else:
			LoadOre(1,false)
	else:
		LoadOre(1,false)
	pass # Replace with function body.

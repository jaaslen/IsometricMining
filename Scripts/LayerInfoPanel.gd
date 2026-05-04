extends Control

var Order = [1,2,3,5,7,6,4,13,14,16,18,22,9,15,8,12,17,32,34,11,10,28,23,20,24,25,27,36,21,26,31,35,38,29,37,33,30,19,39,40]


@export var ActualLayer = Global.GameData["layers"]["0"]
@export var Layer = Global.GameData["layers"]["0"]

@onready var DepthSlider = $FullContainer/HBoxContainer/Data/HSlider
@onready var Indicators = $FullContainer/HBoxContainer/Data/Indicators
@onready var PanelStyle = load("uid://bu0qaxonbmuh1").duplicate(true)
@onready var Buttons = %VerticalContainer
@onready var IDlabel = $FullContainer/HBoxContainer/Data/HBoxContainer/Panel3/ID
#@onready var Icon = $FullContainer/HBoxContainer/Layer/Panel/MarginContainer/Icon
@onready var Name = $FullContainer/HBoxContainer/Data/HBoxContainer/Label
@onready var DepthRange = $FullContainer/HBoxContainer/Data/HBoxContainer/Depthrange
@onready var InfoContainer = $FullContainer/HBoxContainer/Data/ScrollContainer/OreInfo
#@onready var MinDepth = $FullContainer/HBoxContainer/VBoxContainer2/ScrollContainer/InfoContainer/PanelContainer/Container/Text/MinValue
#@onready var MinDescription = $FullContainer/HBoxContainer/VBoxContainer2/ScrollContainer/InfoContainer/PanelContainer/Container/Description
#@onready var MaxDepth = $FullContainer/HBoxContainer/VBoxContainer2/ScrollContainer/InfoContainer/PanelContainer2/Container/Text/MaxValue
#@onready var MaxDescription = $FullContainer/HBoxContainer/VBoxContainer2/ScrollContainer/InfoContainer/PanelContainer2/Container/Description
#@onready var OptimalDepth = $FullContainer/HBoxContainer/VBoxContainer2/ScrollContainer/InfoContainer/PanelContainer3/Container/Text/OptValue
#@onready var OptDescription = $FullContainer/HBoxContainer/VBoxContainer2/ScrollContainer/InfoContainer/PanelContainer3/Container/Description
#@onready var Hardness = $FullContainer/HBoxContainer/VBoxContainer2/ScrollContainer/InfoContainer/PanelContainer4/Container/Text/Hardness
#@onready var HardDescription = $FullContainer/HBoxContainer/VBoxContainer2/ScrollContainer/InfoContainer/PanelContainer4/Container/Description

@onready var Description = $FullContainer/ScrollContainer/Description

#@onready var RareLabel = $FullContainer/HBoxContainer/Data/HBoxContainer/Panel/Rarity
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_viewport().connect("size_changed", Callable(self, "update_position_and_scale"))
	update_position_and_scale()
	
	LoadLayer(0)
	reconnect()

func reconnect():
	if Buttons != null:
		for i in Buttons.get_children():
			if i.is_connected("LayerSelected",LoadLayer) == false:
				i.LayerSelected.connect(LoadLayer)
	if Indicators != null:
		for i in Indicators.get_children():
			if i.is_connected("pressed",DepthButtonPressed) == false:
				i.pressed.connect(DepthButtonPressed.bind(i))


func LoadLayer(LayerID,opening = true):
	
	
	
	
	visible = true
	
	Layer = Global.GameData["layers"][var_to_str(LayerID)]
	
	
	

		
	
	var A = Layer["start"]
	var B = Layer["end"]
	
	DepthSlider.min_value = A
	DepthSlider.max_value = B
	#DepthSlider.step = 0.1
	
	
	var index = 1
	for i in Indicators.get_children():
		if i.name != "Start":
			i.visible = true
			var ButtonDepth = A + (B-A)/20 * index

			i.text = str(int(ButtonDepth)) + "m"
			
			
			if int(ButtonDepth) == int( A + (B-A)/20 * (index-1)):
				i.visible = false
				
			
			
			index += 1
	
	Indicators.get_node("Start").text = "  " + str(int(A)) + "m"
	Indicators.get_node("Start").visible = true
	Indicators.move_child(Indicators.get_node("Start"),0)
	
	modulate = Color(Layer["color"]) * 0.5 + Color(0.65,0.65,0.65) 
	
	ActualLayer = Global.GameData["layers"][var_to_str(LayerID)]
	if ActualLayer["id"] < 10:
		IDlabel.text = "#00" + var_to_str(ActualLayer["id"])
	elif ActualLayer["id"] < 100:
		IDlabel.text = "#0" + var_to_str(ActualLayer["id"])
	else:
		IDlabel.text = "#" + var_to_str(ActualLayer["id"])
	if Layer["id"] not in Global.FoundLayers:
		Layer = Global.GameData["layers"]["0"]

	PanelStyle.border_color = Color(Layer["color"])  / 5 + Color(0.25,0.25,0.25,1)
	PanelStyle.bg_color = Color(Layer["color"]) / 10 +Color(0.15,0.15,0.15,1)

	#var atlas = Layer["atlas"]
	#RareLabel.text = ""
	#for i in range(ActualLayer["rarity"]):
		#RareLabel.text += "★"
	#for i in range(5-ActualLayer["rarity"]):
		#RareLabel.text += "☆"
	
	#RareLabel.text = "★"
	Name.text = Layer["name"]
	DepthRange.text = str(int(Layer["start"])) + "M - " + str(int(Layer["end"])) + "M"
	#Name.self_modulate = Color(Layer["color"]) + Color(0.2,0.2,0.2) #add_theme_color_override("font_color",Color(Layer["color"])*1.2)
	#Name.add_theme_color_override("font_outline_color",Color(Layer["color"]))
	Description.text = Layer["description"]
	#Icon.texture = Icon.texture.duplicate(true)
	#Icon.texture.region = Rect2(Vector2(Global.TileSize.x * atlas[0],2 * Global.TileSize.y * atlas[1]),Vector2(Global.TileSize.x,Global.TileSize.y * 2))#Rect2(Vector2(Global.TileSize.x * atlas[0],2 * Global.TileSize.y * atlas[1]),Vector2(Global.TileSize.x,Global.TileSize.y * 2))#Rect2(Vector2(64 * atlas[0],68 * atlas[1])*2,Vector2(64,68)*2)
	
	InfoContainer.LoadLayerOres(LayerID)
	DepthSlider.value = DepthSlider.min_value
	#if Layer["id"] == 0:
		#MinDepth.text = "%sm" % int(ActualLayer["arrival"])
		#MaxDepth.text = "???m"
		#Hardness.text = "???"
		#OptimalDepth.text = "???m"
		#OptimalDepth.add_theme_font_size_override("font_size",50)
	#else:
	#
		#MinDepth.text = "%sm" % int(Layer["arrival"])
		#MaxDepth.text = "%sm" % int(Layer["depth"][-1][0])
		#Hardness.text = "%s" % int(Layer["hardness"])
		#if Layer["optimal"].size() == 2:
			#OptimalDepth.text = "%s-%sm " % [int(Layer["optimal"][0]),int(Layer["optimal"][1])]
			#OptDescription.text = "This layer is most common at a depth of [color=white]%s[/color]-[color=white]%s[/color]m." % [int(Layer["optimal"][0]),int(Layer["optimal"][1])]
			#OptimalDepth.add_theme_font_size_override("font_size",40)
		#else:
			#OptimalDepth.text = "%sm" % int(Layer["optimal"][0])
			#OptDescription.text = "This layer is most common at a depth of [color=white]%d[/color]m." % int(Layer["optimal"][0])
			#OptimalDepth.add_theme_font_size_override("font_size",50)
			#
	#MinDescription.text = "This layer first starts appearing at a depth of [color=white]%d[/color]m." % int(Layer["arrival"])
	#MaxDescription.text = "This layer will stop appearing past a depth of [color=white]%d[/color]m." % int(Layer["depth"][-1][0])
	#HardDescription.text = "This layer has a toughness %sx harder than stone" % int(Layer["hardness"])
	
		
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
		if position.distance_squared_to(ClosedPos) < 100:
			position = ClosedPos
			Closing = false
			Open = false
		
	elif Opening:
		position = position.lerp(OpenPos,delta * 7)
		if position.distance_squared_to(OpenPos) < 100:
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
	if event.is_action_pressed("Esc"):
		if Open:
			ButtonPressed()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	ButtonPressed()
	pass # Replace with function body.

					 
func LeftPress() -> void:
	if int(Layer["id"]-1) in Global.FoundLayers:
		if Layer["id"] == 0:
			var index = 0
			for i in Global.FoundLayers:
				if i == false:
					
					if index == 0:
						pass
					else:
						LoadLayer(index-1,false)
				index += 1
		else:
			LoadLayer(int(Layer["id"]-1),false)
	
	


func RightPress() -> void:
	if int(Layer["id"]+1) in Global.FoundLayers:
		LoadLayer(int(Layer["id"]+1),false)

		
		#for i in range(LayersInGame):
			#if Global.FoundLayers[LayersInGame-i] == true:
				#LoadLayer(Global.IndexFromSorting(1),false)


func update_position_and_scale():
	var vp_size = get_viewport_rect().size
	if Open == false and Opening == false and Closing == false:
		position.x = vp_size.x
	ClosedPos = Vector2(vp_size.x,0)
	
	#scale.x = 4 * vp_size.x / reference_resolution.x
	#scale.y = scale.x
	#emit_signal("Scaled")


func DepthButtonPressed(ButtonNode):
	DepthSlider.value = float(ButtonNode.text.left(-1))

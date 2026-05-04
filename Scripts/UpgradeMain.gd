extends Control
var Opening
var Closing

var Open = false
var Upgrades = Global.GameData["upgrades"]
var Selected : int = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	
func _process(delta: float) -> void:
	if Closing:
		size = size.lerp(Vector2(0,0),delta * 10)
		position = position.lerp(get_viewport_rect().size + Vector2(300,300),delta*10)
		if size.distance_squared_to(Vector2(0,0)) < 100:
			size = Vector2(0,0)
			position = get_viewport_rect().size + Vector2(300,300)
			visible = false
			Closing = false
			Open = false
			#modulate = Color(0,0,0,0)
			visible = false
			#emit_signal("MenuClosed")
		
	elif Opening:
		size = size.lerp(get_viewport_rect().size,delta * 10)
		position = position.lerp(Vector2(0,0),delta*10)
		if size.distance_squared_to(get_viewport_rect().size) < 100:
			size = get_viewport_rect().size
			position = Vector2(0,0)
			Open = true
			Opening = false
			visible = true
			#emit_signal("MenuOpened")
			
			



func OpenButtonPressed() -> void:
	
	if Opening:
		
		
		
		Opening = false
		Closing = true
		emit_signal("MenuClosed")
	elif Closing:
		
		SFX.play_sfx("Open Panel",0.6)
		
		Opening = true
		Closing = false
		modulate = Color(1,1,1,1)
		#%Control.LoadOre(1,false)
		#%GridContainer.AddScenes()
		
	else:
		Closing = Open
		Opening = !Open
		if Open:
			pass
			#emit_signal("MenuClosed")
		else:
			visible = true
			SFX.play_sfx("Open Panel",0.6)
			
			modulate = Color(1,1,1,1)


func UpgradesSelected(ID) -> void:
	
	
	
	Selected = ID
	
	if ID in Global.Upgrades or Global.LevelPoints < int(Upgrades[str(ID)]["cost"]):
		$Info/InfoVBox/HBoxContainer/Unlock.visible = false
	else:
		$Info/InfoVBox/HBoxContainer/Unlock.visible = true
	
	
	$Info/InfoVBox/Name.text = Upgrades[str(ID)]["name"]
	$Info/InfoVBox/Description.text = Upgrades[str(ID)]["description"]
	$Info/InfoVBox/Cost.text = "Cost: " + str(int(Upgrades[str(ID)]["cost"])) + " Level Points" 
	$Info.modulate = Color(Upgrades[str(ID)]["color"]) * 0.5 + Color(0.5,0.5,0.5)
	pass # Replace with function body.


func _on_unlock_pressed() -> void:
	if Global.LevelPoints >= Upgrades[str(Selected)]["cost"]:
		SFX.play_sfx("Success",0.8,-3)
		$Info/InfoVBox/HBoxContainer/Unlock.visible = false
		$ScrollContainer/Upgrades.GetUpgrade(Selected)
	pass # Replace with function body.




func OtherButtonPressed() -> void:
	pass # Replace with function body.

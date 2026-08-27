extends VBoxContainer

signal UpgradeSelected

var Upgrades = Global.GameData["upgrades"]
var ButtonScene : PackedScene = preload("res://Scenes/UpgradeButton.tscn")

var Images = [preload("res://Visuals/Upgrades/0.png"),preload("res://Visuals/Upgrades/1.png"),
preload("res://Visuals/Upgrades/2.png"),preload("res://Visuals/Upgrades/3.png"),preload("res://Visuals/Upgrades/4.png")]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AddUpgrades()
	#GetUpgrade(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func UpgradeButtonPressed(ID):
	emit_signal("UpgradeSelected",ID)

func AddUpgrades():
	
	var highestlevel : int = -1
	for upgrade in Upgrades.values():
		
		
		
		var NewButton = ButtonScene.instantiate()
		NewButton.name = str(int(upgrade["id"]))
		NewButton.get_node("TextureRect").texture = Images[(int(upgrade["image"]))]
		if int(upgrade["id"]) in Global.Upgrades:
			#NewButton.disabled = true
			NewButton.modulate = Color(upgrade["color"])
			
			NewButton.Effect(false)
			if highestlevel < upgrade["level"]:
				highestlevel = upgrade["level"]
		else:
			if Global.LevelPoints >= upgrade["cost"]:
				NewButton.modulate = Color(0.5,0.5,0.5,1)
				NewButton.Effect(true)
			else:
				NewButton.modulate = Color(0.2,0.2,0.2,1)
				NewButton.Effect(false)
		NewButton.pressed.connect(UpgradeButtonPressed.bind(int(upgrade["id"])))
		
		get_child(upgrade["level"]).get_child(0).add_child(NewButton)

		
	for i in self.get_children():
		if int(i.name) > highestlevel + 1:
			i.visible = false
			
	
			
func GetUpgrade(ID : int):
	
	var upgrade = Upgrades[str(ID)]
	
	if Global.LevelPoints >= upgrade["cost"]:
		
		var upgradebutton = get_child(int(upgrade["level"])).get_child(0).get_node(str(int(ID)))
		#upgradebutton.disabled = true
		upgradebutton.modulate = Color(upgrade["color"])
		upgradebutton.Effect(true)
		
		get_child(int(upgrade["level"])+1).visible = true
		Global.Upgrades.append(ID)
		Global.LevelPoints -= upgrade["cost"]
		CheckUpgrades()
		Global.SetBaseStats()

func CheckUpgrades():
	for upgrade in Upgrades.values():
		var ButtonNode = get_child(int(upgrade["level"])).get_child(0).get_node(str(int(upgrade["id"])))
		if int(upgrade["id"]) in Global.Upgrades:
			#ButtonNode.disabled = true
			ButtonNode.modulate = Color(upgrade["color"])
			ButtonNode.Effect(false)
		else:
			if Global.LevelPoints >= upgrade["cost"]:
				ButtonNode.modulate = Color(0.5,0.5,0.5,1)
			else:
				ButtonNode.modulate = Color(0.2,0.2,0.2,1)
				ButtonNode.Effect(false)

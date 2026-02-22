extends VBoxContainer
signal PickaxesReady
signal PickaxeSetup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)
	
	
	Setup()

	Global.SelectPickaxe(1)
	get_child(0)._on_pressed()
	emit_signal("PickaxesReady")


func NewPickaxe(__):
	Setup()
	#for i in self.get_children():
		#i.queue_free()
	#for Pickaxe in Global.GameData["pickaxes"].values():
		#
		#if Pickaxe["base"] == true:
			#
			#var ID = int(var_to_str(Pickaxe["id"]))
			#var NewInventoryItem = load("uid://xok4ed1xpd5x").instantiate()
			#if Global.SaveData["unlocked"][ID] == false:
				#ID = 0
				#
			#NewInventoryItem.Forged = Global.SaveData["forged"][ID]
			#NewInventoryItem.Pickaxe = Global.GameData["pickaxes"][var_to_str(ID)]
			##NewInventoryItem.ID = ID
#
			#add_child(NewInventoryItem)
		#
#
	#pass # Replace with function body.


func PickaxeChanged(__) -> void:
	Setup()
	#for i in self.get_children():
		#i.queue_free()
	#for Pickaxe in Global.GameData["pickaxes"].values():
		#
		#
		#
		#if Pickaxe["base"] == true:
			#var CurrentLevel = Global.PickaxeLevels[Pickaxe["id"]]
			#
			#var ID = int(var_to_str(Pickaxe["id"]))
			#var NewInventoryItem = load("uid://xok4ed1xpd5x").instantiate()
			#if Global.SaveData["unlocked"][ID] == false:
				#ID = 0
				#
			#NewInventoryItem.Forged = Global.SaveData["forged"][ID]
			#if CurrentLevel > 0:
				#NewInventoryItem.Pickaxe = Global.GameData["pickaxes"][var_to_str(1000 * ID + (CurrentLevel-1))]
			#else:
				#NewInventoryItem.Pickaxe = Global.GameData["pickaxes"][var_to_str(ID)]
			##NewInventoryItem.ID = ID
#
			#add_child(NewInventoryItem)

func Setup():
	for i in self.get_children():
		i.queue_free()
	for Pickaxe in Global.GameData["pickaxes"].values():

		if Pickaxe["base"] == true:
			var CurrentLevel = Global.PickaxeLevels[Pickaxe["id"]]
			
			var ID = int(var_to_str(Pickaxe["id"]))
			var NewInventoryItem = load("uid://xok4ed1xpd5x").instantiate()
			if Global.SaveData["unlocked"][ID] == false:
				ID = 0
				
			NewInventoryItem.Forged = Global.ForgedPickaxes[ID]
			if CurrentLevel > 0:
				NewInventoryItem.Pickaxe = Global.GameData["pickaxes"][var_to_str(1000 * (CurrentLevel) + ID)]
			else:
				NewInventoryItem.Pickaxe = Global.GameData["pickaxes"][var_to_str(ID)]
			#NewInventoryItem.ID = ID
			add_child(NewInventoryItem)

extends VBoxContainer
signal PickaxesReady
signal PickaxeSetup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.PickaxeChanged.connect(PickaxeChanged)
	
	
	for i in self.get_children():
		i.queue_free()
	for Index in range(1,Global.PickaxesInGame):
		
		var NewInventoryItem = load("uid://xok4ed1xpd5x").instantiate()
		if Global.GameData["pickaxes"][var_to_str(Index)]["unlocked"] == false:
			Index = 0
			
		NewInventoryItem.Forged = Global.GameData["pickaxes"][var_to_str(Index)]["forged"]
		NewInventoryItem.Pickaxe = Global.GameData["pickaxes"][var_to_str(Index)]
		#NewInventoryItem.index = Index

		add_child(NewInventoryItem)

		
	emit_signal("PickaxesReady")

func NewPickaxe(_id):
	for i in self.get_children():
		i.queue_free()
	for Index in range(1,Global.PickaxesInGame):
		
		var NewInventoryItem = load("uid://xok4ed1xpd5x").instantiate()
		if Global.GameData["pickaxes"][var_to_str(Index)]["unlocked"] == false:
			Index = 0
		NewInventoryItem.Forged = Global.GameData["pickaxes"][var_to_str(Index)]["forged"]
			
			
		
		NewInventoryItem.Pickaxe = Global.GameData["pickaxes"][var_to_str(Index)]
		#NewInventoryItem.index = Index
		
		add_child(NewInventoryItem)
		

	pass # Replace with function body.


func PickaxeChanged(_PickaxeID) -> void:
	for i in self.get_children():
		i.queue_free()
	for Index in range(1,Global.PickaxesInGame):
		
		var NewInventoryItem = load("uid://xok4ed1xpd5x").instantiate()
		if Global.GameData["pickaxes"][var_to_str(Index)]["unlocked"] == false:
			Index = 0
		NewInventoryItem.Forged = Global.GameData["pickaxes"][var_to_str(Index)]["forged"]
			
			
		
		NewInventoryItem.Pickaxe = Global.GameData["pickaxes"][var_to_str(Index)]
		add_child(NewInventoryItem)
		
	emit_signal("PickaxeSetup")
	pass # Replace with function body.

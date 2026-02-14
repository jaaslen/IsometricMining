extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func PickaxesReady() -> void:
	pass
#
	##for i in $Selection/VBoxContainer/ScrollContainer/PickaxeSelection.get_children():
		##i.PickaxeSelected.connect(PickaxeSelected)
	##$StatsPanel/Stats/CostPanel/VBoxContainer/ForgeButton.PickaxeSelected.connect(PickaxeSelected)
	##$StatsPanel/Upgrades/CostPanel/VBoxContainer/Button.PickaxeSelected.connect(PickaxeSelected)
	#PickaxeSelected(Global.GameData["pickaxes"]["1"])
	#pass # Replace with function body.
#
#func PickaxeSetup():
	#for i in $Selection/VBoxContainer/ScrollContainer/PickaxeSelection.get_children():
		#if i.is_connected("PickaxeSelected",PickaxeSelected) == false:
			#i.PickaxeSelected.connect(PickaxeSelected)
	#if $StatsPanel/Stats/CostPanel/VBoxContainer/ForgeButton.is_connected("PickaxeSelected",PickaxeSelected) == false:
		#$StatsPanel/Stats/CostPanel/VBoxContainer/ForgeButton.PickaxeSelected.connect(PickaxeSelected)
	##$StatsPanel/Upgrades/CostPanel/VBoxContainer/Button.PickaxeSelected.connect(PickaxeSelected)
#
	#
#func PickaxeSelected(Pickaxe):
	#$StatsPanel/Upgrades/VBoxContainer/UpgradeSelection.NewPickaxe(Pickaxe["id"])
	#$StatsPanel/Stats/ScrollContainer/StatsList.NewPickaxe(Pickaxe["id"])
	#
	#if Pickaxe["forged"] == false:
		#$StatsPanel/Stats/CostPanel.visible = true
		#$StatsPanel/Stats/CostPanel/VBoxContainer/ScrollContainer/OreCosts.NewPickaxe(Pickaxe["id"])
		#
		#$StatsPanel.set_tab_disabled(1,true)
		#if $StatsPanel.current_tab == 1:
			#$StatsPanel.select_previous_available()
#
	#else:
		#$StatsPanel/Stats/CostPanel.visible = false
		#$StatsPanel.set_tab_disabled(1,false)
		#
	#
		#
	#pass

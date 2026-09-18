# Trait_database.gd
extends Node
class_name TraitDatabase

func _ready() -> void:
	for upgrade in Global.GameData["upgrades"].values():
		var newupgrade
		var path = "res://Boosts/Upgrades/Resources/" + upgrade["name"] + ".tres"
		
		if ResourceLoader.exists(path):
			newupgrade = load(path)
		else:
			
			if upgrade["stat"] == true:
				newupgrade = StatUpgrade.new()
				newupgrade.Mult = upgrade["amount"]
				newupgrade.Stat = upgrade["type"]
				newupgrade.Multiply = upgrade["multiply"]
				ResourceSaver.save(newupgrade,path)
			elif upgrade["stat"] == false:
				newupgrade = AddTrait.new()
	#for Trait in Global.GameData["trait"].values():
		#var newtrait
		#var path = "res://Boosts/Traits/Resources/" + Trait["name"] + ".tres"
		#
		#if ResourceLoader.exists(path):
			#newtrait = load(path)
		#else:
			#
			#if Trait["stat"] == true:
				#newtrait = StatUpgrade.new()
				#newtrait.Mult = Trait["amount"]
				#newtrait.Stat = Trait["type"]
				#newtrait.Multiply = Trait["multiply"]
				#ResourceSaver.save(newtrait,path)
			#elif Trait["stat"] == false:
				#newtrait = AddTrait.new()


@export var Traits := {
}


var UpgradeClasses = {
	"STAT" : StatUpgrade,
	"LEVEL" : LevelUpgrade
}



func GetTrait(id: int) -> Boost:
	var TraitName = Global.GameData["traits"][str(id)]["name"]
	
	
	return load("res://Boosts/Traits/Resources/" + TraitName + ".tres")
	
func GetUpgrade(id : int) -> Boost:
	
	var UpgradeName = Global.GameData["upgrades"][str(id)]["name"]
	
	
	return load("res://Boosts/Upgrades/Resources/" + UpgradeName + ".tres")
	

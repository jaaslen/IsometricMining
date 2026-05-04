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


@export var Traits := {
}


var UpgradeClasses = {
	"STAT" : StatUpgrade,
	"LEVEL" : LevelUpgrade
}



func GetTrait(id: int) -> Boost:
	return Traits.get(id)
	
func GetUpgrade(ID : int) -> Boost:
	
	var UpgradeName = Global.GameData["upgrades"][str(ID)]["name"]
	
	
	return load("res://Boosts/Upgrades/Resources/" + UpgradeName + ".tres")
	

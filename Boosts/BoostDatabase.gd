# Trait_database.gd
extends Node
class_name TraitDatabase

@export var Traits := {
	5: preload("res://Boosts/Traits/Resources/StoneProficiency.tres"),
	6: preload("res://Boosts/Traits/Resources/StoneStruggle.tres")
}

@export var Upgrades := {
	0 : preload("res://Boosts/Upgrades/Resources/LevelBoost.tres")
}

func GetTrait(id: int) -> Boost:
	return Traits.get(id)
	
func GetUpgrade(id: int) -> Boost:
	return Upgrades.get(id)
	

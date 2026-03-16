# Trait_database.gd
extends Node
class_name TraitDatabase

@export var Traits := {
	1: preload("res://Boosts/Traits/Resources/StoneProficiency.tres")
}

@export var Boosts := {
	"Level": preload("res://Boosts/Traits/Resources/LevelBoost.tres")
}

func GetTrait(id: int) -> Boost:
	return Traits.get(id)
	
func GetBoost(id: String) -> Boost:
	return Boosts.get(id)
	

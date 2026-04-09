# Trait_database.gd
extends Node
class_name TraitDatabase

@export var Traits := {
	5: preload("res://Boosts/Traits/Resources/StoneProficiency.tres"),
	6: preload("res://Boosts/Traits/Resources/StoneStruggle.tres")
}

@export var Boosts := {
	"Level": preload("res://Boosts/Traits/Resources/LevelBoost.tres")
}

func GetTrait(id: int) -> Boost:
	return Traits.get(id)
	
func GetBoost(id: String) -> Boost:
	return Boosts.get(id)
	

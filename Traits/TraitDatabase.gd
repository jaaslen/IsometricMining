# Trait_database.gd
extends Node
class_name TraitDatabase

@export var Traits := {
	1: preload("res://Traits/Resources/StoneProficiency.tres")
}

func GetTrait(id: int) -> PickaxeTrait:
	return Traits.get(id)

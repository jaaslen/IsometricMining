# skill_database.gd
extends Node
class_name SkillDatabase

@export var skills := {
	1: preload("res://skills/Resources/StoneProficiency.tres")
}

func GetSkill(id: int) -> PickaxeSkill:
	return skills.get(id)

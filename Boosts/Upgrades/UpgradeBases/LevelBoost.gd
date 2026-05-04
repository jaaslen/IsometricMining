# Trait_speed.gd
extends Boost
class_name LevelUpgrade
@export var Stat = "POWER"
@export var Mult := 1.0
@export var Multiply : bool = true

func Apply(_MinedBlock, context):
	if Multiply:
		context.MultStats[Stat] *= (Global.Level["boost"] * Mult)
	else:
		context.BaseStats[Stat] += Global.Level["boost"] * Mult

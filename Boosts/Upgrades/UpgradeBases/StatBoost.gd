# Trait_speed.gd
extends Boost
class_name StatUpgrade
@export var Stat = "POWER"
@export var Mult := 1.0
@export var Multiply : bool = true

func Apply(_MinedBlock, context):
	if Multiply:
		context.MultStats[Stat] *= Mult
	else:
		context.BaseStats[Stat] += Mult

# Trait_speed.gd
extends Boost
class_name PowerUpgrade
@export var PowerMult := 1.0

func Apply(MinedBlock, context):
	context.Stats["Power"] *= PowerMult

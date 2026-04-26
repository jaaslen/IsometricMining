# Trait_speed.gd
extends Boost
class_name LevelUpgrade

func Apply(MinedBlock, context):
	context.Stats["POWER"] *= Global.Level["boost"]

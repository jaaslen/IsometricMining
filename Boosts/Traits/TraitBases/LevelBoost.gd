# Trait_speed.gd
extends Boost
class_name LevelBoost

func Apply(MinedBlock, context):
	context.Power *= Global.Level["boost"]

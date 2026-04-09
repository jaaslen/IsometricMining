# Trait_speed.gd
extends Boost
class_name OreProficiency
@export var PowerMult := 5.0
@export var BlockIDs := [-1]
var Type : String = "Mining"

func Apply(MinedBlock, context):
	if BlockIDs == [-1] or MinedBlock in BlockIDs:
		context.Power *= PowerMult
	return

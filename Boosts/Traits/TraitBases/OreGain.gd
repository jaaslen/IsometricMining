# Trait_speed.gd
extends Boost
class_name OreGain
@export var OreMult := 1
@export var BlockIDs := [-1]
var Type : String = "Mining"

func Apply(MinedBlock : int, context : MiningContext):
	if BlockIDs == [-1] or MinedBlock in BlockIDs:
		context.OreMultiplier *= OreMult
	return

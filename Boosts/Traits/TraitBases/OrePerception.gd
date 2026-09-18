# Trait_speed.gd
extends Boost
class_name OrePerception
@export var MinumumRarity := 5
@export var BlockIDs := [-1]
var Type : String = "Mining"

func Apply(MinedBlock : int, context : MiningContext):
	if BlockIDs == [-1] or MinedBlock in BlockIDs:
		pass
		#context.OreGlow *= OreMult
	return

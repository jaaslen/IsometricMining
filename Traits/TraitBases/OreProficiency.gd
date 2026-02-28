# Trait_speed.gd
extends PickaxeTrait
class_name OreProficiency

@export var PowerMult := 5
@export var BlockID := -1

func Apply(MinedBlock, context):
	if BlockID != -1 and MinedBlock != BlockID:
		return
	context.Power *= PowerMult

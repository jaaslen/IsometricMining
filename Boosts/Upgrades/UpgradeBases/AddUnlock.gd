# Trait_speed.gd
extends Boost
class_name AddUnlock
@export var TraitName : String = "POWER"

func Apply(_MinedBlock, context):
	context.set(TraitName,true) #*= PowerMult

	

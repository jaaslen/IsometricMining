# Trait_speed.gd
extends Boost
class_name AddTrait
@export var TraitName : String = "POWER"

func Apply(_MinedBlock, context):
	context.set(TraitName,true) #*= PowerMult

	

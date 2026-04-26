# mining_context.gd
class_name MiningContext

var Stats : Dictionary[String,float] = {
	"POWER" : 1.0,
	"DELAY" : 1.0,
	"XP MULT" : 1.0,
	"LUCK" : 1.0,
	"RARE LUCK" : 1.0
}

var mine_adjacent: bool = false
var MultiMine : int = 1

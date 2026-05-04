# mining_context.gd
class_name MiningContext

var MultStats : Dictionary[String,float] = {
	"POWER" : 1.0,
	"DELAY" : 1.0,
	"XP MULT" : 1.0,
	"LUCK" : 1.0,
	"RARE LUCK" : 1.0,
	"V. RARE LUCK" : 1.0,
	"DEPTH" : 1.0,
	"STORAGE" : 1.0,
	"MULTI MINE" : 1.0
}

var BaseStats : Dictionary[String,float] = {
	"POWER" : 1.0,
	"DELAY" : 1.0,
	"XP MULT" : 1.0,
	"LUCK" : 1.0,
	"RARE LUCK" : 1.0,
	"V. RARE LUCK" : 1.0,
	"DEPTH" : 1.0,
	"STORAGE" : 1.0,
	"MULTI MINE" : 1.0
}

var Stats : Dictionary[String,float] = {
	"POWER" : 1.0,
	"DELAY" : 1.0,
	"XP MULT" : 1.0,
	"LUCK" : 1.0,
	"RARE LUCK" : 1.0,
	"V. RARE LUCK" : 1.0,
	"DEPTH" : 1.0,
	"STORAGE" : 1.0,
	"MULTI MINE" : 1.0
}

var DepthGain : int = 0
var MineAdjacent: bool = false
var MULTIMINE : int = 1

func CalculateStats():
	for i in Stats:
		Stats[i] = BaseStats[i] * MultStats[i]
		
	return Stats

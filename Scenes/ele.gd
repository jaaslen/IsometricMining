extends TextureRect


func _ready() -> void:
	#Global.DepthChanged.connect(NewLayer)
	Global.MovedBetween.connect(MovedBetween)
	#NewLayer()
	pass # Replace with function body.



#func NewLayer(_Layer = null) -> void:
	##$Depth/Amount.text = str(int(Global.Depth)) + "M"
	#text = str(int(Global.Depth)) + "M"
	#
	##$Power/Amount.text = "%" + str(int(Global.DepthPower * 100.0))
	#pass
	
func MovedBetween(boolean):
	visible = boolean

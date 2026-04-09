extends PanelContainer
@export var Name : String
@export var Value : float
@export var ID : int
#@onready var Modulate = Color(1,1,1,1)
@onready var NameLabel = $Container/Text/Name
@onready var ValueLabel = $Container/Text/Value
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NameLabel.text = Name
	ValueLabel.text = Global.Suffix(Value)
	
	pass # Replace with function body.

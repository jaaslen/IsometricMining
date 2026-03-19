extends PanelContainer
@export var Name : String
@export var Value : float

@onready var NameLabel = $Container/Text/Name
@onready var ValueLabel = $Container/Text/Value
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NameLabel.text = Name
	ValueLabel.text = Global.Suffix(Value)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

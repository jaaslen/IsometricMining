extends ProgressBar
signal DelayFinished
var Active = false
var DesiredTime : float = 0.0
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float):
	if Active:
		if timer.is_stopped():
			
			emit_signal("DelayFinished")
			visible = false
			Active = false

		else:
			value = DesiredTime - timer.time_left
			
			

			

			

				


func Mined() -> void:
	visible = true
	
	DesiredTime = Global.Stats["DELAY"]
	min_value = 0
	max_value = DesiredTime
	value = 0
	timer.stop()
	timer.wait_time = DesiredTime
	timer.start()
	Active = true

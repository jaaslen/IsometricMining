extends ProgressBar
@onready var Camera : Camera2D = %Camera2D
@onready var timer: Timer = $Timer
var DesiredTime: float

func ShowTime(desired_time: float,oreid) -> void:
	if desired_time == 0:
		value = 0
		visible = false
	else:
		visible = true
		DesiredTime = desired_time
		min_value = 0
		max_value = desired_time
		value = 0

		var Ore = Global.GameData["ores"][var_to_str(oreid)]

		var Original := get_theme_stylebox("fill")
		var style := Original.duplicate(true)
		style.bg_color = Color.html(Ore["color"])
		add_theme_stylebox_override("fill", style)

		timer.stop()
		timer.wait_time = desired_time
		timer.start()
	
	
	

func _process(_delta):
	if timer.is_stopped():
		visible = false
		return
	value = DesiredTime - timer.time_left
	var completion = (value / max_value)
	if DesiredTime > 1:
		Camera.zoom = Vector2((1 + completion * 0.3) ,(1 + completion * 0.3))

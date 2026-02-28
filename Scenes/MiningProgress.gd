extends ProgressBar
@onready var Camera : Camera2D = %Camera2D
@onready var timer: Timer = $Timer
var DesiredTime: float
var OrePosition: Vector2 = Vector2(0,0)
var Extent = 0.3

var Active = false

func ShowTime(desired_time: float,oreid,Position) -> void:
	Active = true
	OrePosition = Position
	
	if desired_time == 0:
		OrePosition = Vector2(0,0)
		value = 0
		Camera.zoom = Vector2(1,1)
		visible = false
		timer.stop()
	else:
		Camera.toggle(true)
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
		
		Extent = 0.15 * Ore["rarity"]
	
	
	

func _process(delta):
	if Active or 1==1:
		if timer.is_stopped():
			visible = false
			Camera.position = Vector2(960,540)
			#Camera.zoom = Vector2(1,1)
			Camera.toggle(false)
			Camera.Return()
			Active = false
			return
		else:
			value = DesiredTime - timer.time_left
			
			
			var completion = floor((value / max_value) * 7) / 7.0
			
			if DesiredTime > 1:
				Camera.zoom = lerp(Camera.zoom,Vector2((1 + completion * (Extent)) ,(1 + completion * (Extent))), 50 * delta)
				
				#Camera.position =  (4*OrePosition * completion) + Vector2(960,540)

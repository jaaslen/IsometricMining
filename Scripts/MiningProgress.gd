extends ProgressBar
@onready var Camera : Camera2D = %Camera2D
@onready var timer: Timer = $Timer

var DesiredTime: float
var MoveCamera : bool = false
var OrePosition: Vector2 = Vector2(0,0)
var Extent = 0.3
var SFXTime : float
var Active = false

func ShowTime(desired_time: float,oreid,Position) -> void:
	Active = true
	
	var Ore = Global.GameData["ores"][var_to_str(oreid)]

	if DesiredTime >= 1 and oreid != 1:
		MoveCamera = true
	else:
		MoveCamera = false

	
	OrePosition = Position
	
	if desired_time <= 0:
		OrePosition = Vector2(0,0)
		value = 0
		Camera.zoom = Vector2(1,1)
		visible = false
		timer.stop()
	else:
		visible = true
		DesiredTime = desired_time
		min_value = 0
		max_value = desired_time
		value = 0

		

		#var Original := get_theme_stylebox("fill")
		#var style := Original.duplicate(true)
		#style.bg_color = Color.html(Ore["color"])
		#add_theme_stylebox_override("fill", style)
		
		modulate = Color(Ore["color"]) * 0.7 + Color(0.3,0.3,0.3,1)
		
		timer.stop()
		timer.wait_time = desired_time
		SFXTime = (desired_time / 7)
		timer.start()
		
		Extent = 0.15 * Ore["rarity"]
	
	
	

func _process(_delta : float):
	if Active:
		if timer.is_stopped():
			
			
			visible = false
			#Camera.offset = Vector2(0,0)
			Camera.position = Vector2(960,540)
			#Camera.zoom = Vector2(1,1)
			Camera.Return()
			Active = false
			return
		else:
			value = DesiredTime - timer.time_left
			
			
			var completion = floor((value / max_value) * 7) / 7.0
			
			var NormalizedCompletion = Vector2(1 + completion * (Extent) , (1 + completion * (Extent)))
			

			
			if MoveCamera:
				Camera.zoom = NormalizedCompletion
				Camera.position = Vector2(960,540) + (OrePosition * 2 * completion)
			else:
				Camera.zoom = Vector2(1,1)
				
				
				

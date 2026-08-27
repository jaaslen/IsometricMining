extends ProgressBar
@onready var Camera : Camera2D = %Camera2D
@onready var timer: Timer = $Timer

var DesiredTime: float
var MoveCamera : bool = false
#var OrePosition: Vector2 = Vector2(0,0)
var Extent = 0.3
var SFXTime : float
var Active = false

func ShowTime(_desired_time: float,oreid,_Position) -> void:
	
	var Ore = Global.GameData["ores"][var_to_str(oreid)]

	
	
	modulate = Color(Ore["color"]) * 0.7 + Color(0.3,0.3,0.3,1)
	Camera.zoom = Vector2(1,1)
	Camera.position = Vector2(960,540)
		
		
	
	
	

func _process(_delta : float):
	pass
	#if Active:
		#if timer.is_stopped():
			#
			#
			#visible = false
			##Camera.offset = Vector2(0,0)
			#Camera.position = Vector2(960,540)
			##Camera.zoom = Vector2(1,1)
			#Camera.Return()
			#Active = false
			#return
		#else:
			#value = DesiredTime - timer.time_left
			#
			#
			#var completion = floor((value / max_value) * 7) / 7.0
			#
			#var NormalizedCompletion = Vector2(1 + completion * (Extent) , (1 + completion * (Extent)))
			#
#
			#
			#if MoveCamera:
				#Camera.zoom = NormalizedCompletion
				#Camera.position = Vector2(960,540) + (OrePosition * 2 * completion)
			#else:
				#Camera.zoom = Vector2(1,1)
				
				
				


func _on_detection_frame_changed(MiningTime,Coords,Frame) -> void:
	
	if MiningTime > 1.0:
		
		var ActionWeight = MiningTime - 1.0
		
		Camera.zoom = (Vector2(Frame / 7.0,Frame / 7.0) * (Extent * min(1,ActionWeight / 10))) + Vector2(1,1)
		Camera.position = Vector2(960,540) + (Coords * 2 * (Frame / 7.0))
		Global.ShakeCamera(ActionWeight)

	



func _on_detection_finished_mining_anim() -> void:
	Camera.zoom = Vector2(1,1)
	Camera.position = Vector2(960,540)
	pass # Replace with function body.

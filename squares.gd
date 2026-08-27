class_name NestedSquares
extends Control

@export var CentreSquareScale: Vector2 = Vector2(0.9,0.9)
@export var CentreSquareOffset: Vector2 = Vector2(0.0,0.0)
@export var EdgeSquareModulate: Color = Color(1,1,1,1)
@export var CenterSquareModulate: Color = Color(1,1,1,1)
@export var CenterSquareAlphaMod: float = 0.0
var ActualOffset : Vector2 = Vector2(0.0,0.0)
@export var CentreSquareRotation : float = 0.0
@export var Clamp : bool = true
@export var FollowMouse : bool = false
@export var MouseMovingMultiplier : float = 1.0

@export var RotatesOrScalesSpeed : float = 1



@export var Rings: int = 3

@export var RotatesOrScales : bool = false
@export var RotateRange : float
@export var ScaleCenter : Vector2 = Vector2(0.8,0.8)
@export var ScaleSides : Vector2 = Vector2(1.0,1.0)

@export var Centers : bool = false
@export var Pulsing : bool = false

var rotationgoal : float = RotateRange

var rotating_or_scaling : bool = false
var atcentre : bool = true
var centre : Vector2 = size / 2.0

var C_originalcol = CenterSquareModulate
var E_originalcol = EdgeSquareModulate

@onready var timer : Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Setup()
	pass # Replace with function body.
#
func Setup():
	rotationgoal = RotateRange
	timer.one_shot = false
	add_child(timer)
	

	timer.start(1.0)

	timer.timeout.connect(Pulse)
	
	if RotatesOrScales:
		CentreSquareScale = ScaleCenter
	
	ActualOffset = CentreSquareOffset
	centre = size / 2.0

func Pulse():
	
	if RotatesOrScales:
		rotating_or_scaling = true
		
	if Pulsing:
		
		var tween = create_tween()
		#tween.tween_property(self,"CenterSquareModulate",Color(0.0, 0.0, 0.0, 1.0),1.0)
		tween.tween_property(self,"EdgeSquareModulate",Color(0.0, 0.0, 0.0, 1.0),1.0)
		await tween.finished
		CenterSquareModulate = C_originalcol
		EdgeSquareModulate = E_originalcol

		# 2 , 1 , -2 , -1
func ProcessAction():
	pass

func _process(delta: float) -> void:
	ProcessAction()
	if FollowMouse:
		centre = size / 2.0
		var adjustedmousepos = (get_local_mouse_position() - centre).rotated(-CentreSquareRotation)
		ActualOffset = CentreSquareOffset + lerp(ActualOffset,(adjustedmousepos) * MouseMovingMultiplier / 2,delta * 50 * RotatesOrScalesSpeed)
		queue_redraw()
		
		
	if rotating_or_scaling:
		if !FollowMouse:
			queue_redraw()
		if atcentre or !Centers:
			CentreSquareScale = lerp(CentreSquareScale,ScaleSides,delta * 10 * RotatesOrScalesSpeed)
			CentreSquareRotation = lerp(CentreSquareRotation,rotationgoal,delta * 10 * RotatesOrScalesSpeed)
			if CentreSquareScale.is_equal_approx(ScaleSides) and (CentreSquareRotation >= -0.01 + rotationgoal and CentreSquareRotation <= 0.01 + rotationgoal):
				rotationgoal = -rotationgoal
				atcentre = false
				rotating_or_scaling = false
				
		elif atcentre == false:
			CentreSquareScale = lerp(CentreSquareScale,ScaleCenter,delta * 10 * RotatesOrScalesSpeed)
			CentreSquareRotation = lerp(CentreSquareRotation,0.0,delta * 10 * RotatesOrScalesSpeed)
			if CentreSquareScale.is_equal_approx(ScaleCenter) and (CentreSquareRotation >= -0.01 and CentreSquareRotation <= 0.01):
				atcentre = true
				rotating_or_scaling = false
		
		
		
	#if rotating_or_scaling:
		#if rotationdirection == 2:
			#CentreSquareScale = lerp(CentreSquareScale,ScaleSides * 1.01,delta * 5 * RotatesOrScalesSpeed)
			#CentreSquareRotation = lerp(CentreSquareRotation,RotateRange.y * 1.01,delta * 5 * RotatesOrScalesSpeed)
			#if CentreSquareRotation >= RotateRange.y:
				#rotationdirection = 1
				#rotating_or_scaling = false
				#CentreSquareRotation = RotateRange.y
			#queue_redraw()
		#if rotationdirection == 1:
			#CentreSquareScale = lerp(CentreSquareScale,ScaleCenter * 1.01,delta * 5 * RotatesOrScalesSpeed)
			#CentreSquareRotation = lerp(CentreSquareRotation,-0.001,delta * 5 * RotatesOrScalesSpeed)
			#if CentreSquareRotation <= 0.0:
				#rotationdirection = -2
				#rotating_or_scaling = false
				#CentreSquareRotation = 0.0
			#queue_redraw()
			#
		#if rotationdirection == -2:
			#CentreSquareScale = lerp(CentreSquareScale,ScaleSides * 1.01,delta * 5 * RotatesOrScalesSpeed)
			#CentreSquareRotation = lerp(CentreSquareRotation,RotateRange.x * 1.01,delta * 5 * RotatesOrScalesSpeed)
			#if CentreSquareRotation <= RotateRange.x:
				#rotationdirection = -1
				#rotating_or_scaling = false
			#queue_redraw()
	#
		#if rotationdirection == -1:
			#CentreSquareScale = lerp(CentreSquareScale,ScaleCenter * 1.01,delta * 5 * RotatesOrScalesSpeed)
			#CentreSquareRotation = lerp(CentreSquareRotation,0.001,delta * 5 * RotatesOrScalesSpeed)
			#if CentreSquareRotation >= 0.0:
				#rotationdirection = 2
				#rotating_or_scaling = false
			#queue_redraw()
	
	
func _draw() -> void:

	for i : float in range(Rings):
		
		var percentage : float = (i / Rings)
		
		var Scale : Vector2 = ( percentage * CentreSquareScale) + ((1.0-percentage) * Vector2(1.0,1.0))
		if Scale.x <= 0.0001:
			Scale.x = 0.02
		if Scale.y <= 0.0001:
			Scale.y = 0.02
		var Rot : float = ( percentage * CentreSquareRotation)
		var Offset : Vector2 = ( percentage * ActualOffset)
		var Modulate : Color = (percentage * CenterSquareModulate + Color(0,0,0,CenterSquareAlphaMod)) + ((1.0-percentage) * EdgeSquareModulate)

		
		#draw_rect(Rect2(position + ((size / 2) * CentreSquareScale),size*CentreSquareScale),Color(1,1,1,1),false,2,false)
		draw_set_transform(centre,Rot)
		#draw_circle(Vector2(0,i),4,Color(1,percentage,percentage,1),true)
		draw_rect(Rect2( Vector2(Offset) - (Scale * centre) , size* Scale),Modulate,false,4,true)
		#draw_set_transform(Vector2(0,0),Rot)

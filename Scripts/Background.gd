extends TextureRect

var Shifting
var Goal = 0
var OriginalColor = Color(1,1,1,1)
var Brightness = 0.5
var OnSurface = true

func _ready():
	Global.ChangeBG.connect(NewBG)
	Global.MovedBetween.connect(SurfaceShift)
	#NewBG(1,Color(1,1,1,1),1)
	
	#ShiftBrightness(0.1)

func NewBG(id,Colour,_brightness):
	texture = load("res://Visuals/Backgrounds/Background" + str(int(id)) + ".png")
	

		##$Fill.modulate = OriginalColor# * Color(0.25,0.25,0.4)
		#
	#else:
	OriginalColor = Colour
		
	material.set("shader_parameter/color", Colour - Color(0.2,0.2,0.2,0))

	#$Fill.modulate = OriginalColor * Color(0.5,0.5,0.75)
	#OriginalColor = Colour + Color(0,0,0,1)
	#ShiftBrightness(brightness)
	#$Fill.color = OriginalColor

func ShiftBrightness(amount : float):
	Goal = amount
	Brightness = material.get("shader_parameter/color").r
	Shifting = true
	#OriginalColor = material.get("shader_parameter/color")
	
func SurfaceShift(ToSurface):
	if ToSurface:
		#ShiftBrightness(1.0)
		#$Fill.modulate = Color(Global.GameData["layers"]["0"]["color"])
		#OnSurface = true
		pass
	else:
		#ShiftBrightness(0.3)
		#OnSurface = false
		pass
	
func _process(delta: float) -> void:
	if Shifting == true:
		Brightness = lerp(Brightness,Goal,3*delta)
		#material.set("shader_parameter/color", OriginalColor * Brightness + Color(0,0,0,1))
		#if OnSurface == false:
		#	$Fill.modulate = OriginalColor * Brightness + Color(0,0,0,1)
		#$Fill.color = Color(Brightness*0.8,Brightness*0.4,Brightness,1)

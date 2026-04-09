extends Button
var PickaxeCost
var PickaxeID
signal PickaxeSelected
var timer : Timer = Timer.new()
@onready var Bar = $Bar
var PressedStage: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func PriceChange(Cost,Buyable,ID) -> void:
	disabled = !Buyable
	PickaxeCost = Cost
	PickaxeID = ID
	
	
	pass # Replace with function body.


func TimeReset():
	PressedStage = 0
	for i in self.get_children():
		if i is Timer:
			i.queue_free()

func _on_pressed() -> void:
	var newtimer = timer.duplicate(true)
	newtimer.wait_time = 5.0
	newtimer.timeout.connect(TimeReset)
	add_child(newtimer)
	newtimer.start()
	
	Global.ShakeCamera(PressedStage)
	
	PressedStage += 1

	if PressedStage >= 5:
		SFX.play_sfx("Low Kick")
		SFX.play_sfx("Success")
		var Index = 0
		for ore in PickaxeCost:
			
			Global.RemoveOre(PickaxeCost[Index][0],PickaxeCost[Index][1])
			Index += 1
		
		#Global.ForgePickaxe(PickaxeID)
		#Global.EquipPickaxe(PickaxeID)
		#emit_signal("PickaxeSelected",Global.GameData["pickaxes"][var_to_str(PickaxeID)])
		PressedStage = 0
		#for i in Global.OreAmounts
	
	pass # Replace with function body.


func _on_button_down() -> void:
	if PressedStage < 4:
		SFX.play_sfx("Tone Hit",float(PressedStage+1) / 5.0)
	SFX.play_sfx("Glass Clink 3")
	SFX.play_sfx("Wood Hit")
		
	Bar.value = float(PressedStage)
	
	pass # Replace with function body.

extends Control

var up := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	for i in $Panel/VBoxContainer/HBoxContainer.get_children():
		if i.name == "1":
			i.Selected()
		else:
			i.Deselected()
	
	pass # Replace with function body.



func _on_button_pressed() -> void:
	
	if up:
		$Button.text = "  Mine Settings  "
		$AnimationPlayer.play("Down")
	else:
		$Button.text = "v"
		$AnimationPlayer.play("Up")
	up = !up
		
	pass # Replace with function body.


func _on_1_pressed() -> void:
	$"Panel/VBoxContainer/HBoxContainer/1".Selected()
	$"Panel/VBoxContainer/HBoxContainer/2".Deselected()
	$"Panel/VBoxContainer/HBoxContainer/3".Deselected()
	Global.MiningMode = 0

func _on_2_pressed() -> void:
	$"Panel/VBoxContainer/HBoxContainer/1".Deselected()
	$"Panel/VBoxContainer/HBoxContainer/2".Selected()
	$"Panel/VBoxContainer/HBoxContainer/3".Deselected()
	Global.MiningMode = 1

func _on_3_pressed() -> void:
	$"Panel/VBoxContainer/HBoxContainer/1".Deselected()
	$"Panel/VBoxContainer/HBoxContainer/2".Deselected()
	$"Panel/VBoxContainer/HBoxContainer/3".Selected()
	Global.MiningMode = 2


func _on_rare_button_pressed() -> void:
	pass # Replace with function body.

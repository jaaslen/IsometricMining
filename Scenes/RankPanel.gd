extends PanelContainer
var Hovering = false
var Resetting = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Hovering:
		var Distance = get_local_mouse_position() - (size / 2)
		$Level.material.set("shader_parameter/y_rot",Distance.x / 4)
		$Level.material.set("shader_parameter/x_rot",-Distance.y / 4)
	if Resetting:
		$Level.material.set("shader_parameter/y_rot",lerp($Level.material.get("shader_parameter/y_rot"),0.0,delta))
		$Level.material.set("shader_parameter/x_rot",lerp($Level.material.get("shader_parameter/x_rot"),0.0,delta))
	pass


func _on_mouse_entered() -> void:
	Hovering = true
	
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	Hovering = false
	Resetting = true
	pass # Replace with function body.

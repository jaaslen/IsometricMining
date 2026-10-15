extends Panel
var tutorial_page : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update() -> void:
	$Images.change(tutorial_page)
	$Text.change(tutorial_page)

func _on_left_pressed() -> void:
	tutorial_page = max(tutorial_page-1,0)
	update()
	pass # Replace with function body.


func _on_right_pressed() -> void:
	tutorial_page = min(tutorial_page+1,10)
	update()
	pass # Replace with function body.

extends Label
var BaseFontSize : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_viewport().connect("size_changed", Callable(self, "UpdateScale"))
	if has_theme_font_size_override("font_size"):
		BaseFontSize = get_theme_font_size("font_size")
	else:
		BaseFontSize = 16
	UpdateScale()


func UpdateScale():
	
	add_theme_font_size_override("font_size",floori(float(BaseFontSize) * (get_viewport_rect().size.x / Global.BaseScreenSize.x)))#


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = "You Have " + str(Global.LevelPoints) + " Level Points"
	pass

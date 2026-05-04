@tool
extends GGSSetting
class_name SettingColourEdit
## Sets the window size. The window will be resized by setting its size to provided values.

## List of available sizes.t
@export var ColourSetting : GGSSetting

func _init() -> void:
	type = TYPE_STRING
	hint = PROPERTY_HINT_NONE
	default = "ffffff"
	section = "display"
	







func apply(value: String) -> void:
	Global.ChangeColorTheme(value)

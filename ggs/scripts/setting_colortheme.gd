@tool
extends GGSSetting
class_name SettingColourTheme
## Changes display mode between fullscreen, borderless, and windowed.

## A setting that can handle window size. Used to set the game window to the correct size after its state changes.
@export var size_setting: GGSSetting


func _init() -> void:
	type = TYPE_INT
	hint = PROPERTY_HINT_ENUM
	hint_string = "F,D,C"
	default = 2
	section = "colour"


func apply(_value: int) -> void:
	if size_setting != null:
		var size_value: int = GGSSaveManager.load_setting_value(size_setting)
		GGS.setting_applied.emit(size_setting, size_value)
		size_setting.apply(size_value)

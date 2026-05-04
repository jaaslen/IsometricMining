#extends MarginContainer

@tool

extends GGSComponent

signal option_selected(option_index: int)

## Options of the list. Note that the option index or id is saved, not its string label.
@export var options: PackedStringArray
## If enabled, the selection will wrap around when reaching the end of options from either side.
@export var wrap_selection: bool = true




func _ready() -> void:
	
	$GridContainer.columns = 4
	
	compatible_types = [TYPE_INT]
	if Engine.is_editor_hint():
		return

	_init_value()
	option_selected.connect(_on_option_selected)
	for i in $GridContainer.get_children():
		i.pressed.connect(ButtonPressed.bind(int(i.name)))
		i.self_modulate = options[int(i.name)]

func ButtonPressed(ID):
	_select(ID)
	
func reset_setting() -> void:
	_select(setting.default)
	apply_setting()


func _init_value() -> void:
	value = GGSSaveManager.load_setting_value(setting)
	#_select(value, false)


func _select(new_index: int, emit_selected: bool = true) -> void:
	value = new_index
	
	Global.ChangeColorTheme(options[value])
	
	if emit_selected:
		option_selected.emit(value)

	



func _on_option_selected(_option_index: int) -> void:
	if can_apply_on_changed():
		apply_setting()





func _on_any_btn_mouse_entered(Btn: Button) -> void:
	GGS.audio_mouse_entered.play()
	if can_grab_focus_on_mouseover():
		Btn.grab_focus()


func _on_any_btn_focus_entered() -> void:
	GGS.audio_focus_entered.play()

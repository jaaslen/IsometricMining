extends RichTextLabel

func _ready() -> void:
	fit_text(self,Vector2(0,106))

func fit_text(label: RichTextLabel, max_size: Vector2, min_size := 8, max_font_size := 64):
	var font := label.get_theme_font("font")
	if font == null:
		return
	
	var font_size := max_font_size

	while font_size > min_size:
		var text_size = font.get_string_size(
			label.text,
			HORIZONTAL_ALIGNMENT_LEFT,
			-1,
			font_size
		)

		if text_size.x <= max_size.x and text_size.y <= max_size.y:
			break

		font_size -= 1
		
	font_size -= 1

	label.add_theme_font_size_override("normal_font_size", font_size)

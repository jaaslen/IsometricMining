extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size.x = self.get_parent().size.x
	#custom_minimum_size.y = pass#(self.get_theme_font("font").get_string_size(text,HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT,-1,get_theme_font_size("normal_font_size")).y / get_theme_font_size("normal_font_size")) * (get_theme_font_size("normal_font_size") + 6)
	pass # Replace with function body.



func FitText():

	var font = get_theme_font("font")
	var labelsize = size.x - 10
	var labelheight = size.y - 10
	var fontsize = 60
	while font.get_string_size(text,HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT,-1,fontsize).x > labelsize or font.get_string_size(text,HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT,-1,fontsize).y > labelheight and fontsize > 8:
		fontsize -= 1
		add_theme_font_size_override("font_size", fontsize)
		font = get_theme_font("font")
	
	

extends RichTextLabel


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#size.x = self.get_parent().size.x - 100
	#size.y = self.get_parent().size.y
	#FitText()
	##custom_minimum_s#ize.y = size.y + 20
	#pass # Replace with function body.
#
#
#
#func FitText(panelsize = Vector2.ZERO):
	#
	#var labelsize
	#var labelheight
	#
	#if panelsize.x != 0:
		#labelsize = panelsize.x 
		#labelheight = panelsize.y
	#else:
		#labelsize = size.x - 50
		#labelheight = size.y - 10
	#
	#var font = get_theme_font("normal_font")
	#
	#var fontsize = 80
	#while (font.get_string_size(text,HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT,-1,fontsize).x > labelsize or font.get_string_size(text,HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT,-1,fontsize).y > labelheight) and fontsize > 8:
		#fontsize -= 1
		#add_theme_font_size_override("normal_font_size", fontsize)
		#font = get_theme_font("normal_font")

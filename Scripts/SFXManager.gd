extends Node



var sounds = {
	"ToggleON" : preload("res://Audio/SFX/button toggle on.mp3"),
	"ToggleOFF" : preload("res://Audio/SFX/buttontoggleoff.mp3"),
	"Glass Break" : preload("res://Audio/SFX/glass break.mp3"),
	"Glass Clink" : preload("res://Audio/SFX/glass clink.mp3"),
	"Glass Clink 2" : preload("res://Audio/SFX/glass clink 2.mp3"),
	"Glass Clink 3" : preload("res://Audio/SFX/glass clink 3.mp3"),
	"Shine" : preload("res://Audio/SFX/shine.mp3"),
	"Shine 2" : preload("res://Audio/SFX/shine 2.mp3"),
	"Shine 3" : preload("res://Audio/SFX/shine 3.mp3"),
	"Shine 4" : preload("res://Audio/SFX/shine 4.mp3"),
	"Shine Pad" : preload("res://Audio/SFX/shine 4.mp3"),
	"Hover" : preload("res://Audio/SFX/hover.mp3"),
	"Success" : preload("res://Audio/SFX/success ring.mp3"),
	"Metal Button" : preload("res://Audio/SFX/metal button.mp3"),
	"Ring Button" : preload("res://Audio/SFX/ring button.mp3"),
	"Low Kick" : preload("res://Audio/SFX/low kick.mp3"),
	"Rock Break" : preload("res://Audio/SFX/rock break 2.mp3"),
	"Stone Drop" : preload("res://Audio/SFX/stonedrop.mp3"),
	"Cinematic Hit" : preload("res://Audio/SFX/cinematic hit.mp3"),
	"Cinematic Hit 2" : preload("res://Audio/SFX/cinematic hit 2.mp3"),
	"Metal Hit" : preload("res://Audio/SFX/metal hit.mp3"),
	"Tone Hit" : preload("res://Audio/SFX/tone hit.mp3"),
	"Wood Hit" : preload("res://Audio/SFX/wood hit.mp3"),
	"Open Panel" : preload("res://Audio/SFX/open panel.mp3")
}


func play_sfx(SFXName: String, pitch : float = 1.0, DBshift = 0):
	if sounds.has(SFXName):
		
		var player = AudioStreamPlayer.new()
		player.set_bus("SFX")
		player.volume_db = DBshift
		player.pitch_scale = pitch
		player.stream = sounds[SFXName]
		add_child(player)
		player.play()
		player.finished.connect(player.queue_free)

		
	else:
		push_error("NO SOUND BRO")

func play_with_delay(first_sound: String, second_sound: String, delay_time: float, pitch1 = 1, pitch2 = 1) -> void:
	SFX.play_sfx(first_sound, pitch1)
	
	# Use create_timer safely because this node is always active
	var timer = get_tree().create_timer(delay_time)
	await timer.timeout
	
	SFX.play_sfx(second_sound, pitch2)

func time_sfx(SFXName: String):
	return sounds[SFXName].get_length()

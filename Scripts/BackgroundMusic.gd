extends Control


var Music : Dictionary[int, AudioStreamMP3] = {
	
	0 : preload("res://Audio/Music/Short__Guitar.mp3"),
	1   : preload("res://Audio/Music/Short__Respite.mp3"),
	2   : preload("res://Audio/Music/Short__what.mp3"),
	3   : preload("res://Audio/Music/Song__Ambience.mp3"),
	4   : preload("res://Audio/Music/Song__Darkness.mp3"),
	5   : preload("res://Audio/Music/Song__Echoes.mp3"),
	6   : preload("res://Audio/Music/Song__Electro.mp3"),
	7   : preload("res://Audio/Music/Song__Lava.mp3"),
	8   : preload("res://Audio/Music/Song__Melancholy.mp3"),
	9   : preload("res://Audio/Music/Song__Memory.mp3"),
	10   : preload("res://Audio/Music/Song__Mysteria.mp3"),
	11   : preload("res://Audio/Music/Song__Underwater.mp3"),
	12  : preload("res://Audio/Music/bleeding_out2(1).mp3"),
	13  : preload("res://Audio/Music/Bogart VGM - Scifi Concentration(1).mp3"),
	14  : preload("res://Audio/Music/ChillLofiR.mp3"),
	15  : preload("res://Audio/Music/Chillwave_Nightdrive(1).mp3"),
	16  : preload("res://Audio/Music/core_175bpm.mp3"),
	17  : preload("res://Audio/Music/enchanted tiki 86.mp3"),
	18  : preload("res://Audio/Music/Mandatory Overtime.mp3"),
	19  : preload("res://Audio/Music/Murder on the Metrorail.mp3"),
	20  : preload("res://Audio/Music/Party Sector(1).mp3"),
	21  : preload("res://Audio/Music/song18.mp3"),
	22  : preload("res://Audio/Music/This is Life(1).mp3"),
	23  : preload("res://Audio/Music/Underwater Theme II.mp3"),
	24  : preload("res://Audio/Music/Zander Noriega - Blinding Lights.mp3"),
	25  : preload("res://Audio/Music/Zander Noriega - Perpetual Tension.mp3")
	
}

func _ready() -> void:
	pass


func ChangeSong(SongID : int,Pitch : float = 0.8) -> void:
	if SongID == -1:
		$AudioStreamPlaylist.stop()
	else:
		if $AudioStreamPlaylist.playing:
			$AudioStreamPlaylist.stop()
		if $AudioStreamOnce.stream != Music[SongID]:
			$AudioStreamOnce.stream = Music[SongID]
			$AudioStreamOnce.play()
	
func Next() -> void:
	pass
	


func _on_audio_stream_once_finished() -> void:
	$AudioStreamPlaylist.play()
	pass # Replace with function body.

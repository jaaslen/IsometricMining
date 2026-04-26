extends Control

var Music : Dictionary[int, AudioStreamMP3] = {
	
	0 : preload("res://Audio/Music/Short__Guitar.mp3"),
	1 : preload("res://Audio/Music/Short__Respite.mp3"),
	2 : preload("res://Audio/Music/Short__what.mp3"),
	3 : preload("res://Audio/Music/Song__Ambience.mp3"),
	4 : preload("res://Audio/Music/Song__Darkness.mp3"),
	5 : preload("res://Audio/Music/Song__Echoes.mp3"),
	6 : preload("res://Audio/Music/Song__Electro.mp3"),
	7 : preload("res://Audio/Music/Song__Lava.mp3"),
	8 : preload("res://Audio/Music/Song__Melancholy.mp3"),
	9 : preload("res://Audio/Music/Song__Memory.mp3"),
	10 : preload("res://Audio/Music/Song__Mysteria.mp3"),
	11 : preload("res://Audio/Music/Song__Underwater.mp3")
	
}

func ChangeSong(SongID : int):
	$AudioStreamPlayer.stream = Music[SongID]
	$AudioStreamPlayer.play()

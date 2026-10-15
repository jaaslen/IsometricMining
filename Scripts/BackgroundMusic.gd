extends Control
signal SongPlayed
# Energetic
# Chill
# Moody


var Music : Dictionary[int, Array] = {
	
	17 : [preload("res://Audio/Music/Short__Guitar.mp3"),"Jaaslen","Guitar",17,60], # song, credits, intensity, mood
		14   : [preload("res://Audio/Music/Short__Respite.mp3"),"Jaaslen", "Respite",14], #
		16   : [preload("res://Audio/Music/Short__what.mp3"),"Jaaslen", "What",16],
		8   : [preload("res://Audio/Music/Song__Ambience.mp3"),"Jaaslen", "Ambience",8],
		5   : [preload("res://Audio/Music/Song__Darkness.mp3"),"Jaaslen", "Darkness",5],
	18   : [preload("res://Audio/Music/Song__Echoes.mp3"),"Jaaslen", "Echoes",18],
		15   : [preload("res://Audio/Music/Song__Electro.mp3"),"Jaaslen", "Electro",15],
		10   : [preload("res://Audio/Music/Song__Lava.mp3"),"Jaaslen", "Lava",10],
		3   : [preload("res://Audio/Music/Song__Melancholy.mp3"),"Jaaslen", "Melancholy",3],
		2   : [preload("res://Audio/Music/Song__Memory.mp3"),"Jaaslen", "Memory",2],
		4   : [preload("res://Audio/Music/Song__Mysteria.mp3"),"Jaaslen", "Mysteria",4],
	19   : [preload("res://Audio/Music/Song__Underwater.mp3"),"Jaaslen", "Underwater",19],
	20  : [preload("res://Audio/Music/Bogart VGM - Scifi Concentration(1).mp3"), "Bogart VGM", "Sci-Fi Concentration",20],
		1  : [preload("res://Audio/Music/ChillLofiR.mp3"), "omfgdude", "ChillLofiR",1],
		12  : [preload("res://Audio/Music/Chillwave_Nightdrive(1).mp3"), "Bogart VGM", "Chillwave Nightdrive",12],
		7  : [preload("res://Audio/Music/core_175bpm.mp3"), "p0ss", "Core",7],
		6  : [preload("res://Audio/Music/enchanted tiki 86.mp3"), "cynicmusic", "Enchanted Tiki 86",6],
		9  : [preload("res://Audio/Music/Mandatory Overtime.mp3"), "Joth", "Mandatory Overtime",9],
	21  : [preload("res://Audio/Music/Murder on the Metrorail.mp3"), "joeBaxterWebb", "Murder on the Metrorail",21],
	22  : [preload("res://Audio/Music/Party Sector(1).mp3"), "Joth", "Party Sector",22],
	23  : [preload("res://Audio/Music/song18.mp3"), "cynicmusic", "Crystal Caves",23],
	24  : [preload("res://Audio/Music/This is Life(1).mp3"), "Joth", "Emotional Deluge",24],
		13  : [preload("res://Audio/Music/Underwater Theme II.mp3"), "Cleyton Kauffman", "Underwater Theme II",13],
	25  : [preload("res://Audio/Music/Zander Noriega - Blinding Lights.mp3"), "Zander Noriega", "Blinding Lights",25],
		11  : [preload("res://Audio/Music/Zander Noriega - Perpetual Tension.mp3"), "Zander Noriega", "Perpetual Tension",11],
	26  : [preload("res://Audio/Music/155 November_snow-33_tape_leveled.mp3"), "cynicmusic", "November Snow",26],
	27  : [preload("res://Audio/Music/wednesday_night.mp3"), "Zane Little Music", "Wednesday Night",27],
	28  : [preload("res://Audio/Music/arcticambienttheme.mp3"), "Ted Kerr", "Chill Arctic",28],
	29  : [preload("res://Audio/Music/ChillinWithMyPuzzles.mp3"), "Eric Matyas - soundimage.org", "Chillin With My Puzzles",29],
	30  : [preload("res://Audio/Music/Driving(remastered).mp3"), "jeffmatthews", "Driving",30],
	31  : [preload("res://Audio/Music/DST-MindStream.mp3"), "DST", "MindStream",31],
	32  : [preload("res://Audio/Music/Slow Stride Loop.mp3"), "isaiah658", "Slow Stride",32]
}

var CurrentSongID : int = 1

func _ready() -> void:
	pass


func ChangeSong(SongID : int,Pitch : float = 0.8) -> void:
	if SongID == -1:
		$AudioStreamPlaylist.stop()
	else:
		CurrentSongID = Music[SongID][3]
		if $AudioStreamPlaylist.playing:
			$AudioStreamPlaylist.stop()
		if $AudioStreamOnce.stream != Music[SongID][0]:
			$AudioStreamOnce.stream = Music[SongID][0]
			$AudioStreamOnce.play()
			emit_signal("SongPlayed")
		if !$AudioStreamOnce.playing:
			$AudioStreamOnce.play()
			emit_signal("SongPlayed")
		

	


func _on_audio_stream_once_finished() -> void:
	PlayPlaylist()
	pass # Replace with function body.
	
func PlayPlaylist() -> void:

	if CurrentSongID == 32:
		CurrentSongID = 17
	elif CurrentSongID >= 17:
		CurrentSongID += 1
	else:
		CurrentSongID = randi_range(17,32)

	
	var song = Music[CurrentSongID]
	$AudioStreamPlaylist.stream = song[0]
	$AudioStreamPlaylist.play()
	emit_signal("SongPlayed")

func Next():
	$AudioStreamOnce.playing = false
	if CurrentSongID == 32:
		CurrentSongID = 17
	elif CurrentSongID >= 17:
		CurrentSongID += 1
	else:
		CurrentSongID = randi_range(17,32)

	
	var song = Music[CurrentSongID]
	$AudioStreamPlaylist.stream = song[0]
	$AudioStreamPlaylist.play()
	emit_signal("SongPlayed")
	
func Prev():
	if CurrentSongID == 17:
		CurrentSongID = 32
	elif CurrentSongID >= 18:
		CurrentSongID -= 1
	else:
		CurrentSongID = randi_range(17,32)

	
	var song = Music[CurrentSongID]
	$AudioStreamPlaylist.stream = song
	$AudioStreamPlaylist.play()
	emit_signal("SongPlayed")

func _on_audio_stream_playlist_finished() -> void:
	PlayPlaylist()
	pass # Replace with function body.

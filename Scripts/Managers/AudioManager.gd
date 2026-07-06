extends Node


var music_player: AudioStreamPlayer


func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	add_child(music_player)


func play_music(stream: AudioStream):
	if music_player.stream == stream:
		return

	music_player.stream = stream
	music_player.play()


func stop_music():
	music_player.stop()


func set_master_volume(value):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(value)
	)


func set_music_volume(value):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear_to_db(value)
	)


func set_sfx_volume(value):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		linear_to_db(value)
	)

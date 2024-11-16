extends Node

@onready var music: Node = $Music
@onready var sfx: Node = $SFX


func play_music(audio: AudioStream, single: bool = false) -> void:
	if not audio:
		return

	if single:
		stop_music()

	for player: AudioStreamPlayer in music.get_children():
		if not player.playing:
			player.stream = audio
			player.play()
			break


func stop_music() -> void:
	for player: AudioStreamPlayer in music.get_children():
		player.stop()


func play_sfx(audio: AudioStream) -> void:
	if not audio:
		return

	for player: AudioStreamPlayer in sfx.get_children():
		if not player.playing:
			player.stream = audio
			player.play()
			break

extends Node


func play(audio: AudioStream, single: bool = false) -> void:
	if not audio:
		return

	if single:
		stop()

	print(get_children())

	for player: AudioStreamPlayer in get_children():
		if not player.playing:
			player.stream = audio
			player.play()
			break


func stop() -> void:
	for player: AudioStreamPlayer in get_children():
		player.stop()

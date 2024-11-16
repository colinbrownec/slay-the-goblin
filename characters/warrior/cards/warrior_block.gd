extends Card

const BLOCK_SFX = preload("res://art/block.ogg")


func apply_effects(targets: Array[Node]) -> void:
	var effect := BlockEffect.new()
	effect.amount = 5
	effect.execute(targets)
	Sounds.play_sfx(BLOCK_SFX)

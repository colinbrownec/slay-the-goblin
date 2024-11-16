# meta-name Card Logic
# meta-description: What happens what a card is played.

extends Card

const AXE_SFX = preload("res://art/axe.ogg")


func apply_effects(targets: Array[Node]) -> void:
	var effect := DamageEffect.new()
	effect.amount = 10
	effect.execute(targets)
	Sounds.play_sfx(AXE_SFX)

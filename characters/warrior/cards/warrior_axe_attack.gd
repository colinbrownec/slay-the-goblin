extends Card


func apply_effects(targets: Array[Node]) -> void:
	var effect := DamageEffect.new()
	effect.amount = 6
	effect.execute(targets)

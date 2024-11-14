extends Card


func apply_effects(targets: Array[Node]) -> void:
	var effect := BlockEffect.new()
	effect.amount = 5
	effect.execute(targets)

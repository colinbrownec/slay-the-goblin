# meta-name Effect
# meta-description: Create an effect which can be applied to a target

class_name NewEffect
extends Effect

var amount := 0


func execute(targets: Array[Node]) -> void:
	for target in targets:
		if not target:
			continue
		if target is Enemy or target is Player:
			target.take_damage(amount)

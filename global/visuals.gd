extends Node

const WHITE_SPRITE_MATERIAL = preload("res://art/white_sprite_material.tres")

func tween_shake(tween: Tween, node: Node2D, strength: float, duration: float = 0.2) -> void:
	if not node:
		return

	var orig_pos := node.position
	var shake_count := 10

	for i in shake_count:
		var offset := Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
		var target := orig_pos + offset * strength
		if i % 2 == 0:
			target = orig_pos
		tween.tween_property(node, "position", target, duration / float(shake_count))
		strength *= 0.8

	tween.tween_callback(func(): node.position = orig_pos)

func tween_damage_shake(tween: Tween, node: Node2D, damage: int) -> void:
	node.material = WHITE_SPRITE_MATERIAL
	tween_shake(tween, node, 16, 0.2)
	tween.tween_callback(func(): node.material = null)


func tween_tint(tween: Tween) -> void:
	pass

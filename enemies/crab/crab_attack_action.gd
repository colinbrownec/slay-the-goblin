extends EnemyAction

@export var damage := 7


func can_perform_action() -> bool:
	return enemy and target


func perform_action() -> void:
	# create animation tween to make enemy "attack" the target
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 32
	var targets: Array[Node] = [target]
	var damage_effect := DamageEffect.new()
	damage_effect.amount = damage

	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	tween.tween_property(enemy, "global_position", end, 0.4)
	tween.tween_callback(damage_effect.execute.bind(targets))
	tween.tween_interval(0.25)
	tween.tween_property(enemy, "global_position", start, 0.4)
	tween.finished.connect(Events.enemy_action_completed.emit.bind(enemy))

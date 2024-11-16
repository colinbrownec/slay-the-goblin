# meta-name Enemy Action
# meta-description: An action which be performed by an enemy on its turn.

extends EnemyAction

@export var damage := 10

const ENEMY_ATTACK_SFX = preload("res://art/enemy_attack.ogg")


func can_perform_action() -> bool:
	return enemy and target


func perform_action() -> void:
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 32

	var damage_effect := DamageEffect.new()
	damage_effect.amount = damage

	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	tween.tween_property(enemy, "global_position", end, 0.4)
	tween.tween_callback(
		func():
			Sounds.play_sfx(ENEMY_ATTACK_SFX)
			damage_effect.execute([target])
	)
	tween.tween_interval(0.25)
	tween.tween_property(enemy, "global_position", start, 0.4)
	tween.finished.connect(Events.enemy_action_completed.emit.bind(enemy))

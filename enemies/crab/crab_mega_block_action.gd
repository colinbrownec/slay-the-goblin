extends EnemyAction

@export var block := 15
@export var hp_threshold := 6

const ACTION_DELAY := 0.6
var already_used := false
const ENEMY_BLOCK_SFX = preload("res://art/enemy_block.ogg")


func can_perform_action() -> bool:
	if not enemy or already_used:
		return false

	var is_low := enemy.stats.health <= hp_threshold
	already_used = is_low

	return is_low


func perform_action() -> void:
	if not enemy:
		return

	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.execute([enemy])
	Sounds.play_sfx(ENEMY_BLOCK_SFX)

	get_tree().create_timer(ACTION_DELAY, false).timeout.connect(
		Events.enemy_action_completed.emit.bind(enemy)
	)

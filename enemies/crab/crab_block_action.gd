extends EnemyAction

@export var block := 6

const ACTION_DELAY := 0.6
const ENEMY_BLOCK_SFX = preload("res://art/enemy_block.ogg")

func can_perform_action() -> bool:
	return enemy != null


func perform_action() -> void:
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.execute([enemy])
	Sounds.play_sfx(ENEMY_BLOCK_SFX)


	get_tree().create_timer(ACTION_DELAY, false).timeout.connect(
		Events.enemy_action_completed.emit.bind(enemy)
	)

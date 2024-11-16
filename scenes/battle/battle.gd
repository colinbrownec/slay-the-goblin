extends Node2D

@export var char_stats: CharacterStats
@export var music: AudioStream
@onready var battle_ui: BattleUI = $BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler
@onready var enemy_handler: EnemyHandler = $EnemyHandler
@onready var player: Player = $Player


func _ready() -> void:
	# Normally, we would do this on a 'Run' level so we keep our health, gold
	# and deck between battles.
	var new_stats: CharacterStats = char_stats.create_instance()
	battle_ui.char_stats = new_stats
	player.stats = new_stats

	# Temporary until further turn actions are implemented
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)

	Events.player_died.connect(_on_player_died)
	enemy_handler.child_order_changed.connect(_on_enemy_handler_child_order_changed)

	start_battle(new_stats)


func start_battle(stats: CharacterStats) -> void:
	Sounds.play_music(music, true)
	enemy_handler.reset_enemy_actions()
	player_handler.start_battle(stats)


func _on_enemy_turn_ended() -> void:
	enemy_handler.reset_enemy_actions()
	player_handler.start_turn()


func _on_player_died() -> void:
	Events.battle_over_screen_requested.emit("Game Over!", BattleOver.Type.LOSE)



func _on_enemy_handler_child_order_changed() -> void:
	if enemy_handler.get_child_count() == 0:
		Events.battle_over_screen_requested.emit("Victorious!", BattleOver.Type.WIN)

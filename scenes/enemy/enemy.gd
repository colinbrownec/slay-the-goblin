class_name Enemy
extends Area2D

const ARROW_OFFSET := 8

@export var stats: EnemyStats : set = set_enemy_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var arrow: Sprite2D = $Arrow
@onready var stats_ui: StatsUI = $StatsUI

@onready var intent_ui: HBoxContainer = $IntentUI
@onready var intent_icon: TextureRect = $IntentUI/Icon
@onready var intent_label: Label = $IntentUI/Label


var enemy_action_picker: EnemyActionPicker
var current_action: EnemyAction:
	set(value):
		current_action = value
		if current_action:
			_set_intent(current_action.intent)


func set_enemy_stats(value: EnemyStats) -> void:
	stats = value.create_instance()

	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		stats.stats_changed.connect(update_action)

	update_enemy()


func setup_ai() -> void:
	if enemy_action_picker:
		enemy_action_picker.queue_free()

	enemy_action_picker = stats.ai.instantiate()
	enemy_action_picker.enemy = self
	add_child(enemy_action_picker)


func update_stats() -> void:
	stats_ui.update_stats(stats)


func update_action() -> void:
	if not enemy_action_picker:
		return

	if not current_action:
		current_action = enemy_action_picker.get_action()
		return

	var new_conditional_action := enemy_action_picker.get_first_conditional_action()
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action


func update_enemy() -> void:
	if not stats is Stats:
		return
	if not is_inside_tree():
		await ready

	sprite_2d.texture = stats.art
	arrow.position = Vector2.RIGHT * (sprite_2d.get_rect().size.x / 2 + ARROW_OFFSET)
	setup_ai()
	update_stats()


func do_turn() -> void:
	stats.block = 0

	if not current_action:
		return

	current_action.perform_action()

func take_damage(damage: int) -> void:
	if stats.health <= 0:
		return

	var tween := create_tween()
	Visuals.tween_damage_shake(tween, sprite_2d, damage)
	tween.tween_callback(
		func():
			stats.take_damage(damage)
			if stats.health <= 0:
				queue_free()
	)


func _set_intent(intent: Intent) -> void:
	if not intent:
		intent_ui.hide()
		return

	intent_icon.texture = intent.icon
	intent_icon.visible = intent.icon != null
	intent_label.text = intent.number
	intent_label.visible = intent.number.length() >= 0
	intent_ui.show()


func _on_area_entered(_area: Area2D) -> void:
	arrow.visible = true


func _on_area_exited(_area: Area2D) -> void:
	arrow.visible = false

class_name EnemyActionPicker
extends Node

@export var enemy: Enemy:
	set(value):
		enemy = value
		for action: EnemyAction in get_children():
			action.enemy = enemy

@export var target: Node2D:
	set(value):
		target = value
		for action: EnemyAction in get_children():
			action.target = target


func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")


func get_action() -> EnemyAction:
	var action := get_first_conditional_action()
	if action:
		return action

	return get_chance_based_action()


func get_first_conditional_action() -> EnemyAction:
	for action: EnemyAction in get_children():
		if not action or action.type != EnemyAction.Type.CONDITIONAL:
			continue

		if action.is_performable():
			return action

	return null


func get_chance_based_action() -> EnemyAction:
	# calculate total weight
	var total_weight := 0.0
	for action: EnemyAction in get_children():
		if not action or action.type != EnemyAction.Type.CHANCE_BASED:
			continue

		if action.is_performable():
			total_weight += action.chance_weight

	# roll based on weighted chance
	var roll := randf_range(0.0, total_weight)
	for action: EnemyAction in get_children():
		if not action or action.type != EnemyAction.Type.CHANCE_BASED:
			continue

		if action.is_performable():
			roll -= action.chance_weight

		if roll <= 0:
			return action

	return null

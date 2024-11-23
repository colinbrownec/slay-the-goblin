extends Node

"res://scenes/battle/battle.tscn"

const BATTLE = preload("res://scenes/battle/battle.tscn")
const BATTLE_REWARD = preload("res://scenes/battle_reward/battle_reward.tscn")
const CAMPFIRE = preload("res://scenes/campfire/campfire.tscn")
const MAP = preload("res://scenes/map/map.tscn")
const SHOP = preload("res://scenes/shop/shop.tscn")
const TREASURE_ROOM = preload("res://scenes/treasure_room/treasure_room.tscn")

@onready var current_view: Node = $CurrentView
@onready var battle_button: Button = $HBoxContainer/BattleButton
@onready var shop_button: Button = $HBoxContainer/ShopButton
@onready var treasure_button: Button = $HBoxContainer/TreasureButton
@onready var rewards_button: Button = $HBoxContainer/RewardsButton
@onready var campfire_button: Button = $HBoxContainer/CampfireButton

@export var run_init: RunInitialization

var character: CharacterStats
const RUN_INITIALIZATION = preload("res://scenes/run/run_initialization.tres")

func _ready() -> void:
	if not run_init:
		return

	match run_init.type:
		RunInitialization.Type.NEW_RUN:
			character = run_init.character.create_instance()

	_connect_signals()
	print("TODO: procedurally generate map")

	# DEBUG
	battle_button.pressed.connect(_change_view.bind(BATTLE))
	shop_button.pressed.connect(_change_view.bind(SHOP))
	treasure_button.pressed.connect(_change_view.bind(TREASURE_ROOM))
	rewards_button.pressed.connect(_change_view.bind(BATTLE_REWARD))
	campfire_button.pressed.connect(_change_view.bind(CAMPFIRE))

func _change_view(scene: PackedScene) -> void:
	print("change view %s" % scene.resource_name)
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	current_view.add_child(scene.instantiate())


func _connect_signals() -> void:
	Events.battle_won.connect(_change_view.bind(BATTLE_REWARD))
	Events.battle_reward_exited.connect(_change_view.bind(MAP))
	Events.campfire_exited.connect(_change_view.bind(MAP))
	Events.shop_exited.connect(_change_view.bind(MAP))
	Events.treasure_room_exited.connect(_change_view.bind(MAP))
	Events.map_exited.connect(_on_map_exited)


func _on_map_exited() -> void:
	print("TODO: from the MAP, change view based on room type")

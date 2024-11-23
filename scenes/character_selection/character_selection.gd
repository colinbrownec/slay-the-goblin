extends Control

const RUN_SCENE = preload("res://scenes/run/run.tscn")
const WARRIOR = preload("res://characters/warrior/warrior.tres")
const WIZARD = preload("res://characters/wizard/wizard.tres")
const ASSASSIN = preload("res://characters/assassin/assassin.tres")

@export var run_init: RunInitialization

@onready var warrior_button: Button = $HBoxContainer/WarriorButton
@onready var title: Label = %Title
@onready var description: Label = %Description
@onready var character_portrait: TextureRect = %CharacterPortrait

var selected_character: CharacterStats : set = _set_selected_character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_warrior_button_pressed()


func _set_selected_character(character: CharacterStats) -> void:
	selected_character = character
	title.text = character.name
	description.text = character.description
	character_portrait.texture = character.portrait


func _on_warrior_button_pressed() -> void:
	selected_character = WARRIOR


func _on_wizard_button_pressed() -> void:
	selected_character = WIZARD


func _on_assassin_button_pressed() -> void:
	selected_character = ASSASSIN


func _on_start_button_pressed() -> void:
	print("start run with %s" % selected_character.name)
	run_init.type = RunInitialization.Type.NEW_RUN
	run_init.character = selected_character
	get_tree().change_scene_to_packed(RUN_SCENE)

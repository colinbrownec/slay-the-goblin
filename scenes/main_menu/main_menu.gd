extends Control

const CHARACTER_SELECTION = preload("res://scenes/character_selection/character_selection.tscn")

@onready var continue_button: Button = %Continue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	continue_button.disabled = true


func _on_continue_pressed() -> void:
	print("continue")


func _on_new_run_pressed() -> void:
	get_tree().change_scene_to_packed(CHARACTER_SELECTION)


func _on_exit_pressed() -> void:
	get_tree().quit()

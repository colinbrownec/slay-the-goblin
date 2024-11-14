class_name Tooltip
extends PanelContainer

@export var fade_seconds := 0.2

@onready var tooltip_icon: TextureRect = $MarginContainer/VBoxContainer/TooltipIcon
@onready var tooltip_text_label: RichTextLabel = $MarginContainer/VBoxContainer/TooltipText

var tween: Tween
var is_visible := false


func _ready() -> void:
	Events.tooltip_requested.connect(show_tooltip)
	Events.tooltip_hide_requested.connect(hide_tooltip)
	modulate = Color.TRANSPARENT
	hide()


func show_tooltip(icon: Texture, text: String) -> void:
	is_visible = true
	tooltip_icon.texture = icon
	tooltip_text_label.text = text

	if tween:
		tween.kill()

	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(show)
	tween.tween_property(self, "modulate", Color.WHITE, fade_seconds)


func hide_tooltip() -> void:
	is_visible = false

	if tween:
		tween.kill()

	get_tree().create_timer(fade_seconds, false).timeout.connect(start_hide_animation)


func start_hide_animation() -> void:
	if not is_visible:
		tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "modulate", Color.TRANSPARENT, fade_seconds)
		tween.tween_callback(hide)

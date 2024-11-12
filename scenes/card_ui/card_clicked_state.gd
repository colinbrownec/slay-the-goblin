extends CardState


func enter() -> void:
	card_ui.color.color = Color.ORANGE
	card_ui.state.text = "CLICKED"
	card_ui.drop_point_detector.monitoring = true


func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING)


#func on_gui_input(event: InputEvent) -> void:
	#if event.is_action_released("left_mouse"):
		#transition_requested.emit(self, CardState.State.BASE)

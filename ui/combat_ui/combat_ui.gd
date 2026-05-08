class_name CombatUI
extends CanvasLayer

signal burst_selected
signal guard_selected
signal flee_selected
signal item_selected
signal attack_selected

@onready var actions_ui : ActionsUI = $actions_ui

func _ready() -> void:
	actions_ui.burst_selected.connect(func(): burst_selected.emit())
	actions_ui.guard_selected.connect(func(): guard_selected.emit())
	actions_ui.item_selected.connect(func(): item_selected.emit())
	actions_ui.flee_selected.connect(func(): flee_selected.emit())
	actions_ui.attack_selected.connect(func(): attack_selected.emit())

func _process(delta: float) -> void:
	pass

func show_actions(value: bool):
	actions_ui.visible = value

func set_remaining_actions(value: int):
	if actions_ui:
		actions_ui.set_remaining_actions(value)
	else:
		push_error("Error: No encuentro el ActionsUI dentro de combat_ui")

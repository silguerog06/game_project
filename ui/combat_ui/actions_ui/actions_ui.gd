class_name ActionsUI
extends CanvasLayer

signal burst_selected
signal guard_selected
signal flee_selected
signal item_selected
signal attack_selected

@export var marker_offset: Vector2

var player_marker: Marker2D

@onready var action_count_label: Label = $UIContainer/LabelMargin/ActionsCounter
@onready var burst_window: ActionWindow = $UIContainer/ActionsGrid/BurstAction
@onready var guard_window: ActionWindow = $UIContainer/ActionsGrid/GuardAction
@onready var item_window: ActionWindow = $UIContainer/ActionsGrid/ItemAction
@onready var flee_window: ActionWindow = $UIContainer/ActionsGrid/FleeAction
@onready var attack_window: ActionWindow = $UIContainer/ActionsGrid/AttackAction

func _ready() -> void:
	
	# Player actions signal connection
	burst_window.action_selected.connect(func(): burst_selected.emit())
	guard_window.action_selected.connect(func(): guard_selected.emit())
	item_window.action_selected.connect(func(): item_selected.emit())
	flee_window.action_selected.connect(func(): flee_selected.emit())
	attack_window.action_selected.connect(func(): attack_selected.emit())
	
	# Recibir posición Player
	GameBus.player_combat_spawned.connect(_on_player_combat_recieved)

func set_remaining_actions(value: int):
	if action_count_label:
		if value >= 2:
			action_count_label.text = "X " + str(value)
			action_count_label.show()
		else:
			action_count_label.hide()
	else:
		push_error("Error: No encuentro el ActionsLabel dentro de actions_ui")

func _on_player_combat_recieved(player_combat: PlayerCombat):
	player_marker = player_combat.player_marker
	_align_menu_with_player()

func _align_menu_with_player():
	var screen_position = player_marker.get_global_transform_with_canvas().origin
	$UIContainer.global_position = screen_position - ($UIContainer.size / 2.0) + marker_offset

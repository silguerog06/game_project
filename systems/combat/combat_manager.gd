extends Node

enum State { START, START_PLAYER_TURN, PLAYER_TURN, ENEMY_TURN, BUSY, WIN, LOSE }

var current_state = State.START

@export var combat_ui: CombatUI

var actions_per_turn: int = 2
var current_actions: int = 0

func _ready():
	if combat_ui:
		combat_ui.burst_selected.connect(_on_burst_pressed)
		combat_ui.guard_selected.connect(_on_guard_pressed)
		combat_ui.item_selected.connect(_on_item_pressed)
		combat_ui.flee_selected.connect(_on_flee_pressed)
		combat_ui.attack_selected.connect(_on_attack_pressed)
	setup_combat()

func setup_combat():
	print("El combate comienza...")
	# Inicializar vida, etc
	current_actions = actions_per_turn
	update_action_label()
	current_state = State.PLAYER_TURN
	print("Es tu turno!")

func change_state(new_state):
	current_state = new_state
	
	# START_PLAYER_TURN
	if current_state == State.START_PLAYER_TURN:
		current_actions = actions_per_turn
		update_action_label()
		change_state(State.PLAYER_TURN)
	
	# PLAYER_TURN
	if current_state == State.PLAYER_TURN:
		if current_actions >= 1:
			combat_ui.show_actions(true)
		else:
			change_state(State.ENEMY_TURN)
	
	# ENEMY_TURN
	if current_state == State.ENEMY_TURN:
		execute_enemy_turn()
	
	
func update_action_label():
	if combat_ui:
		combat_ui.set_remaining_actions(current_actions)
	else:
		push_error("Error: No encuentro el CombatUI dentro de combat_manager")

func execute_enemy_turn():
	print("El enemigo te ataca!")
	await get_tree().create_timer(1.0).timeout
	change_state(State.START_PLAYER_TURN)
	print("Tu turno de nuevo!")


# ACTIONS FUNCTIONS
func _on_burst_pressed():
	if current_state == State.PLAYER_TURN:
		current_actions -= 1
		update_action_label()
		print("\n¡Has seleccionado BURST!")
		change_state(State.BUSY) # Bloqueamos acciones
		await get_tree().create_timer(0.15).timeout
		combat_ui.show_actions(false)
		await get_tree().create_timer(1.5).timeout
		# Lógica
		change_state(State.PLAYER_TURN)
		
func _on_guard_pressed():
	if current_state == State.PLAYER_TURN:
		print("\n¡Has seleccionado GUARD!")
		change_state(State.BUSY) # Bloqueamos acciones
		await get_tree().create_timer(0.15).timeout
		combat_ui.show_actions(false)
		await get_tree().create_timer(1.5).timeout
		# Lógica
		change_state(State.ENEMY_TURN)
		
func _on_item_pressed():
	if current_state == State.PLAYER_TURN:
		print("\n¡Has seleccionado ITEM!")
		change_state(State.BUSY) # Bloqueamos acciones
		await get_tree().create_timer(0.15).timeout
		combat_ui.show_actions(false)
		await get_tree().create_timer(1.5).timeout
		# Lógica
		change_state(State.ENEMY_TURN)

func _on_flee_pressed():
	if current_state == State.PLAYER_TURN:
		print("\n¡Has seleccionado FLEE!")
		change_state(State.BUSY) # Bloqueamos acciones
		await get_tree().create_timer(0.15).timeout
		combat_ui.show_actions(false)
		await get_tree().create_timer(1.5).timeout
		# Lógica
		change_state(State.ENEMY_TURN)

func _on_attack_pressed():
	if current_state == State.PLAYER_TURN:
		print("\n¡Has seleccionado ATTACK!")
		change_state(State.BUSY) # Bloqueamos acciones
		await get_tree().create_timer(0.15).timeout
		combat_ui.show_actions(false)
		await get_tree().create_timer(1.5).timeout
		# Lógica
		change_state(State.ENEMY_TURN)

extends Node

enum State { START, PLAYER_TURN, ENEMY_TURN, BUSY, WIN, LOSE }

var current_state = State.START

@export var combat_ui: CombatUI

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
	current_state = State.PLAYER_TURN
	print("Es tu turno!")

func change_state(new_state):
	current_state = new_state
	
	if current_state == State.ENEMY_TURN:
		execute_enemy_turn()
	
	if current_state == State.PLAYER_TURN:
		combat_ui.show_actions(true)

func execute_enemy_turn():
	print("El enemigo está pensando...")
	await get_tree().create_timer(1.5).timeout
	print("El enemigo te ataca!")
	change_state(State.PLAYER_TURN)
	print("Tu turno de nuevo!")

func _on_burst_pressed():
	if current_state == State.PLAYER_TURN:
		print("\n¡Has seleccionado BURST!")
		change_state(State.BUSY) # Bloqueamos acciones
		await get_tree().create_timer(0.15).timeout
		combat_ui.show_actions(false)
		await get_tree().create_timer(1.5).timeout
		# Lógica
		change_state(State.ENEMY_TURN)
		
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

extends Node

enum State { START, START_PLAYER_TURN, PLAYER_TURN, ENEMY_TURN, BUSY, WIN, LOSE }

var current_state = State.START

@export var combat_ui: CombatUI
@export var target_scene: PackedScene

var target_instance: Node2D
var target_index: int = 0
var targets: Array = []
var actions_per_turn: int = 2
var current_actions: int = 0
var is_burst_active: bool = false
var player_combat: PlayerCombat

func _ready():
	GameBus.player_combat_spawned.connect(func(p): player_combat = p)
	if combat_ui:
		combat_ui.burst_selected.connect(_on_burst_pressed)
		combat_ui.guard_selected.connect(_on_guard_pressed)
		combat_ui.item_selected.connect(_on_item_pressed)
		combat_ui.flee_selected.connect(_on_flee_pressed)
		combat_ui.attack_selected.connect(_on_attack_pressed)
	if target_scene:
		_spawn_target_frame()
	await get_tree().process_frame
	setup_combat()

func setup_combat():
	print("El combate comienza...")
	# Inicializar vida, etc
	current_actions = actions_per_turn
	update_action_label()
	change_state(State.START_PLAYER_TURN)
	print("Es tu turno!")

func change_state(new_state):
	current_state = new_state
	
	match current_state:
		State.START_PLAYER_TURN:
			is_burst_active = false
			update_burst_animation()
			current_actions = actions_per_turn
			update_action_label()
			change_state(State.PLAYER_TURN)
	
		State.PLAYER_TURN:
			if current_actions >= 1:
				combat_ui.show_actions(true)
				start_targeting()
			else:
				change_state(State.ENEMY_TURN)
	
		State.ENEMY_TURN:
			execute_enemy_turn()
	
	
func update_action_label():
	if combat_ui:
		combat_ui.set_remaining_actions(current_actions)
	else:
		push_error("Error: No encuentro el CombatUI dentro de combat_manager")
		
func update_burst_animation():
	if is_burst_active:
		player_combat.animated_sprite.play("idle_burst")
	else:
		player_combat.animated_sprite.play("idle")

func execute_enemy_turn():
	print("El enemigo te ataca!")
	await get_tree().create_timer(1.0).timeout
	change_state(State.START_PLAYER_TURN)
	print("Tu turno de nuevo!")


# ACTIONS FUNCTIONS
func _on_burst_pressed():
	if current_state == State.PLAYER_TURN:
		is_burst_active = !is_burst_active
		update_burst_animation()
		
func _on_guard_pressed():
	if current_state == State.PLAYER_TURN:
		current_actions -= 1
		update_action_label()
		print("\n¡Has seleccionado GUARD!")
		change_state(State.BUSY) # Bloqueamos acciones
		await get_tree().create_timer(0.15).timeout
		combat_ui.show_actions(false)
		await get_tree().create_timer(1.5).timeout
		# Lógica
		change_state(State.PLAYER_TURN)
		
func _on_item_pressed():
	if current_state == State.PLAYER_TURN:
		current_actions -= 1
		update_action_label()
		print("\n¡Has seleccionado ITEM!")
		change_state(State.BUSY) # Bloqueamos acciones
		await get_tree().create_timer(0.15).timeout
		combat_ui.show_actions(false)
		await get_tree().create_timer(1.5).timeout
		# Lógica
		change_state(State.PLAYER_TURN)

func _on_flee_pressed():
	if current_state == State.PLAYER_TURN:
		current_actions -= 1
		update_action_label()
		print("\n¡Has seleccionado FLEE!")
		change_state(State.BUSY) # Bloqueamos acciones
		await get_tree().create_timer(0.15).timeout
		combat_ui.show_actions(false)
		await get_tree().create_timer(1.5).timeout
		# Lógica
		change_state(State.PLAYER_TURN)

func _on_attack_pressed():
	if current_state == State.PLAYER_TURN:
		stop_targeting()
		current_actions -= 1
		update_action_label()
		print("\n¡Has seleccionado ATTACK!")
		change_state(State.BUSY) # Bloqueamos acciones
		await get_tree().create_timer(0.15).timeout
		combat_ui.show_actions(false)
		await get_tree().create_timer(1.5).timeout
		# Lógica
		change_state(State.PLAYER_TURN)

# TARGET FRAME FUNCTIONS
# init
func _spawn_target_frame():
	target_instance = target_scene.instantiate()
	add_child(target_instance)
	target_instance.visible = true

# Llamar cuando enemigo muere
func refresh_targets():
	targets = get_tree().get_nodes_in_group("enemies")
	if target_index >= targets.size():
		target_index = 0
		
# Llamar cuando se mueve cursor (target_index)
func update_target_position():
	if targets.size() > 0:
		var current_enemy = targets[target_index]
		var target_pos = current_enemy.get_node("Marker2D").global_position
		target_instance.global_position = target_pos
		target_instance.play("idle")
		target_instance.visible = true
	else:
		target_instance.visible = false

# Llamar cuando haya que apuntar
func start_targeting():
	refresh_targets()
	target_index = 0
	update_target_position()
	
func stop_targeting():
	if target_instance:
		target_instance.play("selected")
		await target_instance.animation_finished
		target_instance.visible = false
	
# INPUT
func _unhandled_input(event):
	if current_state == State.PLAYER_TURN and targets.size() > 0:
		
		if event.is_action_pressed("ui_right") or event.is_action_pressed("ui_down"):
			target_index = (target_index + 1) % targets.size()
			update_target_position()
			# Opcional: Sonido de "click" al mover
			
		elif event.is_action_pressed("ui_left") or event.is_action_pressed("ui_up"):
			target_index = (target_index - 1 + targets.size()) % targets.size()
			update_target_position()

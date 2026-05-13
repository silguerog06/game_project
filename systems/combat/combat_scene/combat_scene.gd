extends Node2D

const PLAYER_COMBAT = preload("uid://bybydb502ovr")

@export_range(1, 3) var enemy_count: int = 1

func _ready() -> void:
	_spawn_player()
	_spawn_enemies()

func _process(delta: float) -> void:
	pass

func _spawn_player() -> void:
	var p: Node2D = PLAYER_COMBAT.instantiate()
	p.global_position = $EntitiesSpawns/PlayerSpawn.global_position
	add_child(p)

func _spawn_enemies() -> void:
	var enemies: Array[PackedScene] = []
	
	for i in range(enemy_count):
		enemies.append(CombatData.enemy_to_spawn)
	
	var selected_markers: Array = []
	
	match enemy_count:
		1:
			selected_markers = $EntitiesSpawns/EnemyFormations/Formation1.get_children()
		2:
			selected_markers = $EntitiesSpawns/EnemyFormations/Formation2.get_children()
		3:
			selected_markers = $EntitiesSpawns/EnemyFormations/Formation3.get_children()
		_:
			selected_markers = $EntitiesSpawns/EnemyFormations/Formation3.get_children()
			print("[UNEXPECTED] Enemy overflow on spawn")

	for i in range(enemy_count):
		if i < selected_markers.size():
			var enemy_instance = enemies[i].instantiate()
			enemy_instance.global_position = selected_markers[i].global_position
			add_child(enemy_instance)
	
	CombatData.enemies_to_spawn.clear()

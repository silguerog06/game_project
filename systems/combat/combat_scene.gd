extends Node2D

const PLAYER_COMBAT = preload("uid://bybydb502ovr")



func _ready() -> void:
	_spawn_player()
	_spawn_enemies()

func _process(delta: float) -> void:
	pass

func _spawn_player() -> void:
	var p: Node2D = PLAYER_COMBAT.instantiate()
	p.global_position = $PlayerSpawn.global_position
	add_child(p)

func _spawn_enemies() -> void:
	var enemies = CombatManager.enemies_to_spawn
	var count = enemies.size()
	var selected_markers: Array = []
	
	match count:
		1:
			selected_markers = $EnemyFormations/Formation1.get_children()
		2:
			selected_markers = $EnemyFormations/Formation2.get_children()
		3:
			selected_markers = $EnemyFormations/Formation3.get_children()
		_:
			selected_markers = $EnemyFormations/Formation3.get_children()

	for i in range(count):
		if i < selected_markers.size():
			var enemy_instance = enemies[i].instantiate()
			enemy_instance.global_position = selected_markers[i].global_position
			add_child(enemy_instance)
	
	CombatManager.enemies_to_spawn.clear()

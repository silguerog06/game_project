extends Node2D

const PLAYER_COMBAT = preload("uid://bybydb502ovr")

func _ready() -> void:
	_spawn_player()

func _process(delta: float) -> void:
	pass

func _spawn_player() -> void:
	var p: Node2D = PLAYER_COMBAT.instantiate()
	p.global_position = $PlayerSpawn.global_position
	add_child(p)

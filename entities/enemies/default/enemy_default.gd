extends Node2D

@export var enemy_name:= "Enemy"
@export var enemy_max_health: int = 100
@export var enemy_damage: int = 10
var enemy_current_health: int

func _ready():
	GameBus.enemy_marker_ready.emit.call_deferred($Marker2D)
	add_to_group("enemies")
	enemy_current_health = enemy_max_health

func die():
	queue_free()

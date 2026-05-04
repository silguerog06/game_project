extends Node

var current_combat_animations_path: String = "res://assets/resources/player_combat_animations.tres"
var max_health: int = 100
var current_health: int = 100
var experience: int = 0
var level: int = 1
var gold: int = 0

func _ready():
	current_health = max_health
	
func take_damage(amount: int):
	current_health -= amount
	current_health = clamp(current_health, 0, max_health)
		
	if current_health <= 0:
		die()
	else:
		GameBus.emit_signal("player_health_changed", current_health)

func heal(amount: int):
	current_health += amount
	current_health = clamp(current_health, 0, max_health)
	GameBus.emit_signal("player_health_changed", current_health)

func die():
	GameBus.emit_signal("player_died")
	

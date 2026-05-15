class_name PlayerCombat
extends Node2D

signal hp_changed(current, max_value)
signal energy_changed(current, max_value)

var max_hp: int
var max_energy: int
var current_hp: int
var current_energy: int

@onready var animated_sprite = $AnimatedSprite2D
@onready var player_marker = $MarkerUI

func _ready() -> void:
	# Bars_UI
	max_hp = PlayerData.max_hp
	current_hp = PlayerData.current_hp
	GameBus.player_hp_changed.emit(current_hp, max_hp)
	
	max_energy = PlayerData.max_energy
	current_energy = PlayerData.starting_energy
	GameBus.player_energy_changed.emit(current_energy, max_energy)
	
	# Sprite
	var resource_path = load(PlayerData.current_combat_animations_path)
	animated_sprite.sprite_frames = resource_path
	animated_sprite.play("idle")
	GameBus.player_combat_spawned.emit.call_deferred(self)

func take_damage(amount):
	current_hp = clampi(current_hp - amount, 0, max_hp)
	GameBus.player_hp_changed.emit(current_hp, max_hp)
	
	if current_hp <= 0:
		print("¡Has muerto!")
		
func heal_damage(amount):
	current_hp = clampi(current_hp + amount, 0, max_hp)
	GameBus.player_hp_changed.emit(current_hp, max_hp)

func use_energy(amount):
	current_energy = clampi(current_energy - amount, 0, max_energy)
	GameBus.player_energy_changed.emit(current_energy, max_energy)
	
func recover_energy(amount):
	current_energy = clampi(current_energy + amount, 0, max_energy)
	GameBus.player_energy_changed.emit(current_energy, max_energy)

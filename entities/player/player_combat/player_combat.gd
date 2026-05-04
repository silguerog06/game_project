extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	var resource_path = load(PlayerData.current_combat_animations_path)
	animated_sprite.sprite_frames = resource_path
	animated_sprite.play("idle")
	GameBus.player_marker_ready.emit.call_deferred($MarkerUI)

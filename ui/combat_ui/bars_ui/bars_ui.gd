extends CanvasLayer

@onready var health_bar = $LMarginContainer/HBoxContainer/HealthBar
@onready var energy_bar = $LMarginContainer/HBoxContainer/EnergyBar

func _ready() -> void:
	GameBus.player_hp_changed.connect(update_hp)
	GameBus.player_energy_changed.connect(update_energy)

func update_hp(value, max_value):
	health_bar.value = value
	health_bar.max_value = max_value

func update_energy(value, max_value):
	energy_bar.value = value
	energy_bar.max_value = max_value
	

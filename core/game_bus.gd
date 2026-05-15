extends Node

## Este es el Bus de Eventos del juego,
## encargado de recopilar y organizar las distintas señales entre componentes.

# Posicionamiento de entidades al entrar en comabte
signal player_combat_spawned(player_combat: PlayerCombat)
signal enemy_marker_ready(marker: Marker2D)

# Cálculos de combate del jugador
signal player_hp_changed(current_hp: int, max_hp: int)
signal player_energy_changed(current_energy: int, max_energy: int)
signal player_died

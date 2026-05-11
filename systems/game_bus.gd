extends Node

## Este es el Bus de Eventos del juego,
## encargado de recopilar y organizar las distintas señales entre componentes.

# Posicionamiento de entidades al entrar en comabte
signal player_combat_spawned(player_combat: PlayerCombat)
signal enemy_marker_ready(marker: Marker2D)

# Cálculos de combate del jugador
signal player_health_changed(current_health: int)
signal player_died

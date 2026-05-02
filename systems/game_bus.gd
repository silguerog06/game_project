extends Node

## Este es el Bus de Eventos del juego,
## encargado de recopilar y organizar las distintas señales entre componentes.

# Avisa cuando el marker de posición del jugador esta listo para mandarse
signal player_marker_ready(marker: Marker2D)

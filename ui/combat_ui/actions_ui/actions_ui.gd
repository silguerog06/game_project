extends CanvasLayer

var player_marker: Marker2D
@export var marker_offset: Vector2

func _ready() -> void:
	GameBus.player_marker_ready.connect(_on_player_marker_recieved)

func _on_player_marker_recieved(marker: Marker2D):
	player_marker = marker
	_align_menu_with_player()

func _align_menu_with_player():
	var screen_position = player_marker.get_global_transform_with_canvas().origin
	$UIContainer.global_position = screen_position - ($UIContainer.size / 2.0) + marker_offset

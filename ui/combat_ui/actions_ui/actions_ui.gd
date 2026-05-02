extends CanvasLayer

var player_marker: Marker2D
@export var marker_offset: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameBus.player_marker_ready.connect(_on_player_marker_recieved)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_marker:
		_align_menu_with_player()

func _on_player_marker_recieved(marker: Marker2D):
	player_marker = marker
	_align_menu_with_player()

func _align_menu_with_player():
	var screen_position = player_marker.get_global_transform_with_canvas().origin
	$ui_container.global_position = screen_position - ($ui_container.size / 2.0) + marker_offset

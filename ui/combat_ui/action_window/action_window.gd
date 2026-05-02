@tool
extends MarginContainer

@export var button_text: String = "Acción":
	set(value):
		button_text = value
		if is_node_ready():
			$action_button.text = value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$action_button.text = button_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

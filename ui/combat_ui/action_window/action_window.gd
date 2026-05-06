@tool
extends MarginContainer

@onready var internal_button: Button = $action_button

@export var button_text: String = "Acción":
	set(value):
		button_text = value
		if is_node_ready():
			internal_button.text = value
			
@export var action_shortcut: Shortcut:
	set(value):
		action_shortcut = value
		if internal_button:
			internal_button.shortcut = value

func _ready() -> void:
	if action_shortcut:
		internal_button.shortcut = action_shortcut
	internal_button.text = button_text


func _process(delta: float) -> void:
	pass

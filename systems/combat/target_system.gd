extends Node

@export var remember_target: bool = true

var targets: Array = []
var target_index: int = 0
var target_instance: Node2D

func setup(target_frame: Node2D):
	target_instance = target_frame
	refresh_targets()

func refresh_targets():
	targets = get_tree().get_nodes_in_group("enemies")
	if targets.is_empty():
		if target_instance: target_instance.visible = false
		return
	
	if target_index >= targets.size():
		if remember_target:
			target_index = max(0, targets.size() - 1)
		else:
			target_index = 0
	
	update_visuals()

func update_visuals():
	if targets.size() > 0:
		var current_enemy = targets[target_index]
		target_instance.global_position = current_enemy.get_node("Marker2D").global_position
		target_instance.play("idle")
		target_instance.visible = true
	else:
		target_instance.visible = false

func move_selection(direction: int):
	var new_index = clamp(target_index + direction, 0, targets.size() - 1)
	if new_index != target_index:
		target_index = new_index
		update_visuals()
		# Emitir señal sonido click

func get_current_target():
	if targets.size() > 0:
		return targets[target_index]
	return null

func stop_soft():
	if target_instance:
		target_instance.play("selected")
		await target_instance.animation_finished
		target_instance.visible = false
		
func stop_hard():
	target_instance.visible = false

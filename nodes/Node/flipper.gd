@icon("flipper.svg")
class_name Flipper
extends Node
## Used to flip 2D nodes based on the direction they're moving or where they're looking.
## Useful for sprites in platformers, for example.


@export var node: Node2D
@export var additional_nodes: Array[Node2D]
@export var invert: bool = false


func face_dir(dir: Vector2) -> void:
	if not is_instance_valid(node) and additional_nodes.is_empty():
		return

	if dir == Vector2.ZERO:
		return

	_set_node_x_scale(-1 if dir.x > 0.0 else 1)


func face_dir_x(x: float) -> void:
	if not is_instance_valid(node) and additional_nodes.is_empty():
		return

	if x == 0.0:
		return

	_set_node_x_scale(-1 if x > 0.0 else 1)


func face(position: Vector2) -> void:
	if not is_instance_valid(node) and additional_nodes.is_empty():
		return

	_set_node_x_scale(-1 if position.x > node.global_position.x else 1)


func _set_node_x_scale(value: int) -> void:
	node.scale.x = value * (-1 if invert else 1)
	for additional in additional_nodes:
		additional.scale.x = node.scale.x

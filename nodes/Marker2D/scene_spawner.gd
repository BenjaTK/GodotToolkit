class_name SceneSpawner
extends Marker2D


@export var scene: PackedScene
## If [code]true[/code], will add the node as child of the current scene.
## If [code]false[/code], you can use the return value of [method spawn] to parent add it as child of any node.
@export var as_child_of_current_scene: bool = true
@export_group("Copy", "copy_")
@export var copy_rotation: bool = true
@export var copy_position: bool = true
@export var copy_scale: bool = false


func spawn() -> Node:
	var node: Node = scene.instantiate()

	if node is Node2D:
		if copy_rotation:
			node.global_rotation = self.global_rotation
		if copy_position:
			node.global_position = self.global_position
		if copy_scale:
			node.scale = self.scale

	if as_child_of_current_scene:
		get_tree().current_scene.add_child(node)
	return node

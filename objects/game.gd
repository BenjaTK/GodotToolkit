class_name Game
extends Node
## Loads and unloads scenes. Allows for keeping scenes loaded while not running, or removing them entirely.
##
## Built upon from https://youtu.be/32h8BR0FqdI.

signal world_scene_changed(new: Node)
signal gui_scene_changed(new: Node)

## The container that holds the world scene.
@export var world: Node
## The container that holds the GUI scene.
@export var gui: Control
@export_group("Current")
## Currently loaded world scene.[br]
## Set this to a node in-editor if you have a node in the scene tree, otherwise leave empty and see [param initial_world_scene].
@export var current_world_scene: Node
## Currently loaded GUI scene.[br]
## Set this to a node in-editor if you have a node in the scene tree, otherwise leave empty and see [param initial_gui_scene].
@export var current_gui_scene: Node
@export_group("Start-Up")
## Scene to load as world when the game starts as the [param current_world_scene].[br]
## If you want to add from the editor, see [param current_world_scene].
@export var initial_world_scene: PackedScene
## Scene to load as GUI when the game starts as the [param current_gui_scene].[br]
## If you want to add from the editor, see [param current_gui_scene].
@export var initial_gui_scene: PackedScene


func _ready() -> void:
	if initial_world_scene:
		change_world_scene_to_packed(initial_world_scene)

	if initial_gui_scene:
		change_gui_scene_to_packed(initial_gui_scene)


func delete_world_scene() -> void:
	if not is_instance_valid(current_world_scene):
		return

	current_world_scene.queue_free()


## Changes the current world scene node to [param new].[br]
## If [param delete] is [code]false[/code], but [param keep_running] is [code]true[/code], hides the node.[br]
## If [param delete] and [param keep_running] are [code]false[/code], keeps the node in memory by removing as a child of [param gui].
func change_world_scene(new: Node, delete: bool = true, keep_running: bool = false) -> void:
	assert(is_instance_valid(new), "New world scene is invalid.")
	if new == current_world_scene:
		push_warning("World scene is already loaded.")
		return

	if is_instance_valid(current_world_scene):
		if delete:
			current_world_scene.queue_free()
		elif keep_running:
			current_world_scene.visible = false
		else:
			world.remove_child(current_world_scene)

	world.add_child.call_deferred(new)
	current_world_scene = new
	world_scene_changed.emit(current_world_scene)


## Changes the current world scene to [param new_scene].[br]
## If [param delete] is [code]false[/code], but [param keep_running] is [code]true[/code], hides the node.[br]
## If [param delete] and [param keep_running] are [code]false[/code], keeps the node in memory by removing as a child of [param gui].
func change_world_scene_to_packed(new_scene: PackedScene, delete: bool = true, keep_running: bool = false) -> void:
	change_world_scene(new_scene.instantiate(), delete, keep_running)


## Changes the current world scene to [param new_scene_path].[br]
## If [param delete] is [code]false[/code], but [param keep_running] is [code]true[/code], hides the node.[br]
## If [param delete] and [param keep_running] are [code]false[/code], keeps the node in memory by removing as a child of [param gui].
func change_world_scene_to_file(new_scene_path: String, delete: bool = true, keep_running: bool = false) -> void:
	change_world_scene(load(new_scene_path).instantiate(), delete, keep_running)


func delete_gui_scene() -> void:
	if not is_instance_valid(current_gui_scene):
		return

	current_gui_scene.queue_free()


## Changes the current GUI scene node to [param new].[br]
## If [param delete] is [code]false[/code], but [param keep_running] is [code]true[/code], hides the node.[br]
## If [param delete] and [param keep_running] are [code]false[/code], keeps the node in memory by removing as a child of [param gui].
func change_gui_scene(new: Node, delete: bool = true, keep_running: bool = false) -> void:
	assert(is_instance_valid(new), "New GUI scene is invalid.")
	if new == current_world_scene:
		push_warning("GUI scene is already loaded.")
		return

	if is_instance_valid(current_gui_scene):
		if delete:
			current_gui_scene.queue_free()
		elif keep_running:
			current_gui_scene.visible = false
		else:
			gui.remove_child(current_gui_scene)

	gui.add_child.call_deferred(new)
	current_gui_scene = new
	gui_scene_changed.emit(current_gui_scene)


## Changes the current GUI scene to [param new_scene].[br]
## If [param delete] is [code]false[/code], but [param keep_running] is [code]true[/code], hides the node.[br]
## If [param delete] and [param keep_running] are [code]false[/code], keeps the node in memory by removing as a child of [param gui].
func change_gui_scene_to_packed(new_scene: PackedScene, delete: bool = true, keep_running: bool = false) -> void:
	change_gui_scene(new_scene.instantiate(), delete, keep_running)


## Changes the current GUI scene to the scene found at [param new_scene_path].[br]
## If [param delete] is [code]false[/code], but [param keep_running] is [code]true[/code], hides the node.[br]
## If [param delete] and [param keep_running] are [code]false[/code], keeps the node in memory by removing as a child of [param gui].
func change_gui_scene_to_file(new_scene_path: String, delete: bool = true, keep_running: bool = false) -> void:
	change_gui_scene(load(new_scene_path).instantiate(), delete, keep_running)

@icon("pathfinder.svg")
class_name Pathfinder
extends Node2D


signal target_reached
signal navigation_finished
signal path_changed(new_path)

@export var actor : Node2D
@export var velocity_component : VelocityComponent
@export var nav_agent : NavigationAgent2D

var target_position: Vector2
var stopped: bool = false

@onready var path_request_delay : Timer = $PathRequestDelay


func _ready() -> void:
	nav_agent.max_speed = velocity_component.speed
	nav_agent.connect("target_reached", _on_target_reached)
	nav_agent.connect("path_changed", _on_path_changed)
	nav_agent.connect("navigation_finished", _on_navigation_finished)


func set_target_position(target: Vector2) -> void:
	if not path_request_delay.is_stopped():
		return

	await get_tree().physics_frame

	target_position = target
	nav_agent.set_target_position(target_position)
	path_request_delay.start()


func navigate_in_path() -> void:
	stopped = false
	var dir = actor.global_position.direction_to(nav_agent.get_next_path_position())
	if not has_arrived_at_target():
		nav_agent.set_velocity(dir.normalized())
	else:
		velocity_component.stop()


func stop() -> void:
	set_target_position(actor.global_position)
	stopped = true


func has_arrived_at_target() -> bool:
	return nav_agent.is_navigation_finished()


func distance_to_final_position():
	return actor.global_position.distance_to(nav_agent.get_final_position())


func _on_target_reached() -> void:
	target_reached.emit()


func _on_path_changed() -> void:
	path_changed.emit(nav_agent.get_current_navigation_path())


func _on_navigation_finished() -> void:
	navigation_finished.emit()


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	if stopped:
		return

	velocity_component.accelerate_in_direction(safe_velocity.normalized())

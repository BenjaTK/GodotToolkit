@icon("velocity_component.svg")
class_name VelocityComponent
extends Node


@export var base_speed := 96
@export var speed_multiplier: float = 1.0
@export_range(0.0, 1.0) var acceleration := 0.4
@export_range(0.0, 1.0) var friction := 0.4

var speed : get = get_speed
var _velocity := Vector2.ZERO : set = set_velocity, get = get_velocity


func accelerate_to_velocity(new_velocity: Vector2, custom_acceleration = acceleration, custom_friction = friction) -> void:
	_velocity.x = lerp(
			_velocity.x,
			new_velocity.x,
			custom_acceleration if not is_zero_approx(new_velocity.x) else custom_friction
		)
	_velocity.y = lerp(
			_velocity.y,
			new_velocity.y,
			custom_acceleration if not is_zero_approx(new_velocity.y) else custom_friction
		)


func accelerate_in_direction(direction: Vector2, custom_acceleration = acceleration, custom_friction = friction) -> void:
	accelerate_to_velocity(direction * speed, custom_acceleration, custom_friction)


## Add a [Vector2] to the velocity.
func add_force(force: Vector2) -> void:
	_velocity += force


func set_velocity(new_velocity: Vector2) -> void:
	_velocity = new_velocity


func set_velocity_x(value: float) -> void:
	_velocity.x = value


func set_velocity_y(value: float) -> void:
	_velocity.y = value


func get_velocity() -> Vector2:
	return _velocity


## Set the [param character_body]'s velocity to the [VelocityComponent]'s velocity, then call [method CharacterBody2D.move_and_slide].
func move(character_body: CharacterBody2D) -> void:
	character_body.velocity = _velocity
	character_body.move_and_slide()


func stop(custom_friction = friction) -> void:
	accelerate_to_velocity(Vector2.ZERO, acceleration, custom_friction)


func get_speed() -> int:
	return base_speed * speed_multiplier

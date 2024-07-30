class_name ProjectileMovement
extends Node


@export var initial_velocity: Vector2 = Vector2.ZERO
## Move in the direction the owner is looking.
@export var follow_rotation: bool = true
@export var velocity_component: VelocityComponent


func _ready() -> void:
	velocity_component.set_velocity(initial_velocity)


func _physics_process(delta: float) -> void:
	if follow_rotation:
		velocity_component.accelerate_in_direction(Vector2.from_angle(owner.rotation))
	velocity_component.move(owner)

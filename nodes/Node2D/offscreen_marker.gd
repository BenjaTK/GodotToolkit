extends Node2D
# Original code taken from: https://youtu.be/Sw9Iiejkae4 (How to Show Off-Screen Warnings in Godot 3.1 by Game Endeavor)


@onready var sprite: Sprite2D = $Sprite


func _physics_process(delta: float) -> void:
	var canvas = get_canvas_transform()
	var top_left = -canvas.origin / canvas.get_scale()
	var size = get_viewport_rect().size / canvas.get_scale()

	_set_marker_position(Rect2(top_left + Vector2(4, 4), size - Vector2(4, 4)))
	_set_marker_rotation()


func _set_marker_position(bounds: Rect2) -> void:
	sprite.global_position.x = clamp(global_position.x, bounds.position.x, bounds.end.x)
	sprite.global_position.y = clamp(global_position.y, bounds.position.y, bounds.end.y)

	if bounds.has_point(global_position):
		hide()
	else:
		show()


func _set_marker_rotation() -> void:
	var angle = (global_position.angle_to_point(sprite.global_position))
	sprite.global_rotation = angle

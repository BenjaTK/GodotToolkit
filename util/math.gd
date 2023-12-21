class_name Math
extends Object


## Returns [code]true[/code] if [param a] is within [param distance] of [param b].
static func are_within_distance(a: Vector2, b: Vector2, distance: float) -> bool:
	return a.distance_to(b) <= distance


## Returns [code]true[/code] if [param a] is within [param distance] of [param b].
## The distance is squared for increased performance.
static func are_within_distance_squared(a: Vector2, b: Vector2, distance: float) -> bool:
	return a.distance_squared_to(b) <= distance * distance

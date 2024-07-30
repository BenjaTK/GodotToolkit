class_name Math
extends Object


## Returns [code]true[/code] if [param a] is within [param distance] of [param b].
static func are_within_distance(a: Vector2, b: Vector2, distance: float) -> bool:
	return a.distance_to(b) <= distance


## Returns [code]true[/code] if [param a] is within [param distance] of [param b].
## The distance is squared for increased performance.
static func are_within_distance_squared(a: Vector2, b: Vector2, distance: float) -> bool:
	return a.distance_squared_to(b) <= distance * distance



static func get_closest_node_to(nodes: Array[Node2D], to: Node2D) -> Node2D:
	if nodes.size() == 1:
		return nodes.front()

	var closest_distance: float = INF
	var closest_node: Node2D
	for node in nodes:
		var distance: float = node.global_position.distance_squared_to(to.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_node = node

	return closest_node

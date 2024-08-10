class_name Random
extends Object
## New randomization functions.


## [param data] is a [Dictionary] with the structure {[code]object[/code]:[code]weight[/code]}.
static func pick_weighted(data: Dictionary) -> Variant:
	var total_weight := 0.0

	for weight in data.values():
		total_weight += weight

	var rand := randf_range(0.0, total_weight)
	var running_total := 0.0
	for object in data:
		running_total += data[object]
		if rand <= running_total:
			return object

	return null


## The resources in [param resources] have to have a parameter [param weight] of type [code]float[/code].
static func pick_weighted_resource(resources: Array[Resource]) -> Resource:
	var total_weight := 0.0

	for resource in resources:
		var weight: float = resource.get("weight")
		total_weight += weight if weight != null else 0.0

	var rand := randf_range(0.0, total_weight)
	var running_total := 0.0
	for resource in resources:
		var weight: float = resource.get("weight")
		running_total += weight if weight != null else 0.0
		if rand <= running_total:
			return resource

	return null


## Returns a random point between the bounds of [param viewport]. Optional [param margin].
static func get_point_in_screen(viewport: Viewport, margin: float = 0.0) -> Vector2:
	var screen_size := viewport.get_visible_rect().size
	var x := randf_range(margin, screen_size.x - margin)
	var y := randf_range(margin, screen_size.y - margin)
	return Vector2(x, y)


## Returns a random [Vector2] between [param a] and [param b].
static func randv_range(a: Vector2, b: Vector2) -> Vector2:
	return Vector2(randf_range(a.x, b.x), randf_range(a.y, b.y))


## Returns a random [Vector2i] between [param a] and [param b].
static func randvi_range(a: Vector2i, b: Vector2i) -> Vector2i:
	return Vector2i(randi_range(a.x, b.x), randi_range(a.y, b.y))


## Returns a [Vector2] with a random direction.
static func rand_dir() -> Vector2:
	return Vector2.from_angle(randf_range(0.0, TAU))


## Returns -1.0 or 1.0 randomly.
static func randf_sign() -> float:
	return -1.0 if randf() < 0.5 else 1.0

## Returns -1 or 1 randomly.
static func randi_sign() -> int:
	return round(randf_sign())


static func get_random_point_in_radius(position: Vector2, radius: float, min_distance: float = 0.0) -> Vector2:
	var pos: Vector2 = position + Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
	while pos.distance_squared_to(position) < 16384:
		pos = position + Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
	return pos

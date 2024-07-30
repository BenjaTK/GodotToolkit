class_name Health
extends Node


signal health_updated(health: float)
signal damaged(amount: float)
signal healed(amount: float)
signal killed()

@export var max_health := 3.0
@export_range(0.0, 1.0) var invulnerability_duration := 0.1

var _inv_timer: Timer

@onready var health : float = max_health : set = set_health, get = get_health


func _ready() -> void:
	if invulnerability_duration > 0.0:
		_inv_timer = Timer.new()
		_inv_timer.one_shot = true
		_inv_timer.wait_time = invulnerability_duration
		add_child(_inv_timer)


func damage(amount: float) -> void:
	if is_instance_valid(_inv_timer):
		if !_inv_timer.is_stopped():
			return

		_inv_timer.start()

	set_health(health - amount)

	emit_signal("damaged", amount)


func heal(amount: float) -> void:
	set_health(health + amount)
	emit_signal("healed", amount)


func max_out_health() -> void:
	set_health(max_health)


func kill() -> void:
	set_health(0.0)


func set_health(value: float) -> void:
	var prev_health := health
	health = clamp(value, 0.0, max_health)

	if health != prev_health:
		emit_signal("health_updated", health)

		if is_zero_approx(health):
			emit_signal("killed")


func get_health() -> float:
	return health

class_name StateMachine
extends Node


@export var initial_state : State : get = get_initial_state

var _state : State = null : get = get_current_state


func _ready() -> void:
	set_state(initial_state)


func _physics_process(delta: float) -> void:
	if _state != null:
		_state._state_logic(delta)

		var new_state = _state._get_next(delta)
		if new_state != null:
			set_state(new_state)


func set_state(new_state: State) -> void:
	var prev_state : State

	if _state != null:
		prev_state = _state
	_state = new_state

	if prev_state != null:
		prev_state._exited(new_state)
		new_state._entered(prev_state)


func get_current_state() -> State:
	return _state


func get_initial_state() -> State:
	return initial_state


func get_state_by_name_or_null(state_name: String) -> State:
	return get_node_or_null(state_name)

class_name StateMachine
extends Object


var _states: Dictionary
var current_state: Callable : set = set_state, get = get_current_state
var previous_state: Callable : get = get_previous_state


func update(delta: float) -> void:
	if current_state.is_valid():
		current_state.call(delta)


func set_state(new_state: Callable) -> void:
	_call_exited_if_exists(current_state)
	_call_entered_if_exists(new_state)

	previous_state = current_state

	var state_flow: StateFlow = _states.get(new_state)
	if state_flow != null:
		current_state = state_flow.normal
	else:
		current_state = Callable()


func set_initial_state(state: Callable) -> void:
	set_state(state)


## Add normal, exited and entered states.
func add_state(normal: Callable, entered: Callable = Callable(), exited: Callable = Callable()) -> void:
	_states[normal] = StateFlow.new(normal, entered, exited)


func get_current_state() -> Callable:
	return current_state


func get_previous_state() -> Callable:
	return previous_state


func _call_entered_if_exists(callable: Callable) -> void:
	if callable.is_valid():
		var state_flow: StateFlow = _states.get(callable)
		if state_flow != null and state_flow.entered.is_valid():
			state_flow.entered.call()


func _call_exited_if_exists(callable: Callable) -> void:
	if callable.is_valid():
		var state_flow: StateFlow = _states.get(callable)
		if state_flow != null and state_flow.exited.is_valid():
			state_flow.exited.call()


class StateFlow:
	var normal: Callable
	var entered: Callable
	var exited: Callable

	func _init(_normal: Callable, _entered: Callable = Callable(), _exited: Callable = Callable()) -> void:
		normal = _normal
		entered = _entered
		exited = _exited

class_name State
extends Node


@onready var _state_machine : StateMachine = get_parent()
@onready var _actor = _state_machine.get_parent()


func _state_logic(delta: float) -> void:
	pass


func _get_next(delta: float) -> State:
	return null # Return next state.


func _exited(new_state: State) -> void:
	pass


func _entered(prev_state: State) -> void:
	pass

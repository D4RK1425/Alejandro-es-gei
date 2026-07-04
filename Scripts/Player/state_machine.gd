class_name StateMachine
extends Node

@onready var initial_state: State = get_child(0)

var current_state: State
var previous_state: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_machine = self
	if initial_state:
		call_deferred("change_state", initial_state)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func change_state(new_state: State) -> void:
	if current_state == new_state:
		return
	if current_state:
		current_state.exit()
	previous_state = current_state
	current_state = new_state
	current_state.enter()

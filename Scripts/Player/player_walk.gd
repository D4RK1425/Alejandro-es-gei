extends State

@onready var player: CharacterBody2D = owner
@onready var visual: CharacterVisual = player.get_node("Visual")

func enter() -> void:
	visual.play("Walk")

func physics_update(delta: float) -> void:
	var input_dir := Input.get_axis("move_left", "move_right")
	player.velocity.x = input_dir * player.SPEED
	player.velocity.y += player.GRAVITY * delta

	if input_dir != 0:
		visual.set_flip(input_dir > 0)

	player.move_and_slide()

	if not player.is_on_floor():
		state_machine.change_state(player.states["Fall"])
		return
	if input_dir == 0:
		state_machine.change_state(player.states["Idle"])
		return
	if Input.is_action_pressed("run"):
		state_machine.change_state(player.states["Run"])
		return
	if Input.is_action_just_pressed("attack"):
		state_machine.change_state(player.states["Attack"])
		return
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state(player.states["Jump"])

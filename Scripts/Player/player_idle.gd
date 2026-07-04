extends State

@onready var player: CharacterBody2D = owner
@onready var visual: CharacterVisual = player.get_node("Visual")

func enter() -> void:
	visual.play("Idle")
	

func physics_update(delta: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.velocity.y += player.GRAVITY * delta
	player.move_and_slide()

	if not player.is_on_floor():
		state_machine.change_state(player.states["Fall"])
		return

	var input_dir := Input.get_axis("move_left", "move_right")
	if input_dir != 0:
		state_machine.change_state(player.states["Walk"])
	if Input.is_action_just_pressed("attack"):
		state_machine.change_state(player.states["Attack"])
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state(player.states["Jump"])

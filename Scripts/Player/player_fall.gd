extends State

@onready var player: CharacterBody2D = owner
@onready var visual: CharacterVisual = player.get_node("Visual")

func enter() -> void:
	visual.play("Fall")

func physics_update(delta: float) -> void:
	player.velocity.y += player.GRAVITY * delta
	var input_dir := Input.get_axis("move_left", "move_right")
	player.velocity.x = input_dir * player.SPEED

	if input_dir != 0:
		visual.set_flip(input_dir > 0)

	player.move_and_slide()

	if player.is_on_floor():
		if input_dir == 0:
			state_machine.change_state(player.states["Idle"])
		else:
			state_machine.change_state(player.states["Walk"])

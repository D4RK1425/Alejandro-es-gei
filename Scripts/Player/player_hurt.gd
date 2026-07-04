extends State

@onready var player: CharacterBody2D = owner
@onready var visual: CharacterVisual = player.get_node("Visual")

const KNOCKBACK_FORCE := 100.0
const HURT_DURATION := 0.3

var timer := 0.0

func enter() -> void:
	print("Entrando a Hurt")
	visual.play("Idle")
	visual.flash()
	player.velocity.x = player.last_hit_direction * KNOCKBACK_FORCE
	timer = HURT_DURATION

func physics_update(delta: float) -> void:
	player.velocity.y += player.GRAVITY * delta
	player.velocity.x = move_toward(player.velocity.x, 0, 300 * delta)
	player.move_and_slide()

	timer -= delta
	if timer <= 0:
		if player.is_on_floor():
			state_machine.change_state(player.states["Idle"])
		else:
			state_machine.change_state(player.states["Fall"])

extends State

@onready var boss: BossDemonSlime = owner
const HURT_DURATION := 0.3
var timer := 0.0

func enter() -> void:
	boss.sprite.play("TakeHit")
	timer = HURT_DURATION

func physics_update(delta: float) -> void:
	boss.velocity.y += 900 * delta
	boss.velocity.x = move_toward(boss.velocity.x, 0, 200 * delta)
	boss.move_and_slide()

	timer -= delta
	if timer <= 0:
		state_machine.change_state(boss.states["SlimeIdle"])

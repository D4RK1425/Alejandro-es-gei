extends State

@onready var boss: BossDemonSlime = owner
const KNOCKBACK_FORCE := 60.0
const HURT_DURATION := 0.25
var timer := 0.0

func enter() -> void:
	boss.sprite.play("DemonTakeHit")
	boss.velocity.x = boss.last_hit_direction * KNOCKBACK_FORCE
	timer = HURT_DURATION

func physics_update(delta: float) -> void:
	boss.velocity.y += 900 * delta
	boss.velocity.x = move_toward(boss.velocity.x, 0, 200 * delta)
	boss.move_and_slide()

	timer -= delta
	if timer <= 0:
		if boss.target:
			state_machine.change_state(boss.states["DemonChase"])
		else:
			state_machine.change_state(boss.states["DemonIdle"])

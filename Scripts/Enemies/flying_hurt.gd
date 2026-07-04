# flying_hurt.gd
extends State

@onready var enemy: EnemyBase = owner
const KNOCKBACK_FORCE := 60.0
const HURT_DURATION := 0.2

var timer := 0.0

func enter() -> void:
	enemy.sprite.play("Idle")
	enemy.velocity.x = enemy.last_hit_direction * KNOCKBACK_FORCE
	timer = HURT_DURATION

func physics_update(delta: float) -> void:
	enemy.velocity = enemy.velocity.move_toward(Vector2.ZERO, 300 * delta)
	enemy.move_and_slide()

	timer -= delta
	if timer <= 0:
		if enemy.target:
			state_machine.change_state(enemy.states["Chase"])
		else:
			state_machine.change_state(enemy.states["Idle"])

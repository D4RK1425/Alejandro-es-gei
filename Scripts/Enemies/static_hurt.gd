extends State

@onready var enemy: EnemyBase = owner
const KNOCKBACK_FORCE := 40.0
const HURT_DURATION := 0.2

var timer := 0.0

func enter() -> void:
	enemy.sprite.play("Idle")
	if enemy.has_gravity:
		enemy.velocity.x = enemy.last_hit_direction * KNOCKBACK_FORCE
	timer = HURT_DURATION

func physics_update(delta: float) -> void:
	if enemy.has_gravity:
		enemy.velocity.y += 900 * delta
		enemy.velocity.x = move_toward(enemy.velocity.x, 0, 200 * delta)
	enemy.move_and_slide()

	timer -= delta
	if timer <= 0:
		state_machine.change_state(enemy.states["Idle"])

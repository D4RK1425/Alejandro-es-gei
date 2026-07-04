# enemy_vulnerable.gd
extends State

@onready var enemy: EnemyBase = owner
const VULNERABLE_DURATION := 2.5  # tiempo que el jugador tiene para golpearlo

var timer := 0.0

func enter() -> void:
	enemy.sprite.play("Idle")  # o una animación de "aturdido" si el pack la trae
	timer = VULNERABLE_DURATION

func physics_update(delta: float) -> void:
	enemy.velocity.x = 0
	enemy.velocity.y += 900 * delta
	enemy.move_and_slide()

	timer -= delta
	if timer <= 0:
		state_machine.change_state(enemy.states["Chase"])

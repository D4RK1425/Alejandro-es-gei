extends State

@onready var enemy: EnemyBase = owner

func enter() -> void:
	enemy.sprite.play(enemy.move_animation_name)
	

func physics_update(delta: float) -> void:
	enemy.velocity.y += 900 * delta

	if not enemy.target:
		state_machine.change_state(enemy.states["Idle"])
		return

	var dist: float = enemy.global_position.distance_to(enemy.target.global_position)

	if dist <= enemy.attack_range:
		state_machine.change_state(enemy.states[enemy.attack_state_name])
		return
	if dist > enemy.detection_range * 1.5:
		enemy.target = null
		state_machine.change_state(enemy.states["Idle"])
		return

	var dir: float = sign(enemy.target.global_position.x - enemy.global_position.x)
	enemy.velocity.x = dir * enemy.speed
	enemy.face_target()
	enemy.move_and_slide()

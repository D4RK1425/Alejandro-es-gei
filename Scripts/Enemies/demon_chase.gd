extends State

@onready var boss: BossDemonSlime = owner

func enter() -> void:
	boss.sprite.play("DemonWalk")

func physics_update(delta: float) -> void:
	boss.velocity.y += 900 * delta

	if not boss.target:
		state_machine.change_state(boss.states["DemonIdle"])
		return

	var dist: float = boss.global_position.distance_to(boss.target.global_position)
	print("Distancia: ", dist, " | Attack range: ", boss.attack_range)

	if dist <= boss.attack_range:
		state_machine.change_state(boss.states["DemonAttack"])
		return

	var dir: float = sign(boss.target.global_position.x - boss.global_position.x)
	boss.velocity.x = dir * boss.demon_speed
	boss.face_target()
	boss.move_and_slide()

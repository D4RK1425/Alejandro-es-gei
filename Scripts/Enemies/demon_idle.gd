extends State

@onready var boss: BossDemonSlime = owner

func enter() -> void:
	boss.sprite.play("DemonIdle")

func physics_update(delta: float) -> void:
	boss.velocity.y += 900 * delta
	boss.velocity.x = move_toward(boss.velocity.x, 0, boss.demon_speed)
	boss.move_and_slide()

	var player := _find_player_in_range()
	if player:
		boss.target = player
		state_machine.change_state(boss.states["DemonChase"])

func _find_player_in_range() -> Node2D:
	for body in boss.get_node("DetectionArea").get_overlapping_bodies():
		if body.is_in_group("player"):
			return body
	return null

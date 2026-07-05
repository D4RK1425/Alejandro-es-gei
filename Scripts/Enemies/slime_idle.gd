extends State

@onready var boss: BossDemonSlime = owner

func enter() -> void:
	boss.sprite.play("Idle")

func physics_update(delta: float) -> void:
	boss.velocity.y += 900 * delta

	var player := _find_player_in_range()
	if player:
		boss.target = player
		var dir_away: float = sign(boss.global_position.x - player.global_position.x)
		boss.velocity.x = dir_away * boss.slime_speed
		boss.sprite.play("Move")
		boss.sprite.flip_h = dir_away < 0
	else:
		boss.velocity.x = move_toward(boss.velocity.x, 0, boss.slime_speed)
		boss.sprite.play("Idle")

	boss.move_and_slide()

func _find_player_in_range() -> Node2D:
	for body in boss.get_node("DetectionArea").get_overlapping_bodies():
		if body.is_in_group("player"):
			return body
	return null

extends State

@onready var enemy: EnemyBase = owner

func enter() -> void:
	enemy.sprite.play("Idle")

func physics_update(delta: float) -> void:
	enemy.velocity.x = 0
	enemy.velocity.y += 900 * delta
	enemy.move_and_slide()

	var player := _find_player_in_range()
	if player:
		enemy.target = player
		state_machine.change_state(enemy.states["Chase"])

func _find_player_in_range() -> Node2D:
	for body in enemy.get_node("DetectionArea").get_overlapping_bodies():
		if body.is_in_group("player"):
			return body
	return null

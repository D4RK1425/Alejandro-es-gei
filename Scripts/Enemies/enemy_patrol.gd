extends State

@onready var enemy: EnemyBase = owner
@export var patrol_distance := 60.0

var start_x: float
var direction := 1

func enter() -> void:
	start_x = enemy.global_position.x
	enemy.sprite.play("Walk")

func physics_update(delta: float) -> void:
	enemy.velocity.y += 900 * delta
	enemy.velocity.x = direction * enemy.speed * 0.5
	enemy.sprite.flip_h = direction < 0
	enemy.move_and_slide()

	if abs(enemy.global_position.x - start_x) >= patrol_distance:
		direction *= -1

	var player := _find_player_in_range()
	if player:
		enemy.target = player
		state_machine.change_state(enemy.states["Chase"])

func _find_player_in_range() -> Node2D:
	for body in enemy.get_node("DetectionArea").get_overlapping_bodies():
		if body.is_in_group("player"):
			return body
	return null

extends State

@onready var enemy: EnemyBase = owner
@onready var hitbox: Area2D = enemy.get_node("AttackHitbox")
@onready var hitbox_shape: CollisionShape2D = hitbox.get_node("CollisionShape2D")

const HIT_WINDOW_1_START := 6
const HIT_WINDOW_1_END := 8
const HIT_WINDOW_2_START := 14
const HIT_WINDOW_2_END := 16
const MAX_ATTACKS_IN_A_ROW := 4

var attack_count := 0

func enter() -> void:
	hitbox_shape.set_deferred("disabled", true)
	enemy.sprite.play("Attack")
	enemy.sprite.frame_changed.connect(_on_frame_changed)
	enemy.sprite.animation_finished.connect(_on_animation_finished)

func exit() -> void:
	if enemy.sprite.frame_changed.is_connected(_on_frame_changed):
		enemy.sprite.frame_changed.disconnect(_on_frame_changed)
	if enemy.sprite.animation_finished.is_connected(_on_animation_finished):
		enemy.sprite.animation_finished.disconnect(_on_animation_finished)

func physics_update(delta: float) -> void:
	enemy.velocity.x = 0
	enemy.velocity.y += 900 * delta
	enemy.move_and_slide()

func _on_frame_changed() -> void:
	var frame := enemy.sprite.frame
	var in_window_1 := frame >= HIT_WINDOW_1_START and frame <= HIT_WINDOW_1_END
	var in_window_2 := frame >= HIT_WINDOW_2_START and frame <= HIT_WINDOW_2_END
	hitbox_shape.disabled = not (in_window_1 or in_window_2)

func _on_animation_finished() -> void:
	attack_count += 1

	if attack_count >= MAX_ATTACKS_IN_A_ROW:
		attack_count = 0
		state_machine.change_state(enemy.states["Vulnerable"])
		return

	if enemy.target and enemy.global_position.distance_to(enemy.target.global_position) <= enemy.attack_range:
		enemy.sprite.play("Attack")
	else:
		attack_count = 0
		state_machine.change_state(enemy.states["Chase"])

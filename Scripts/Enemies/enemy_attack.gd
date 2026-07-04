extends State

@onready var enemy: EnemyBase = owner
@onready var hitbox: Area2D = enemy.get_node("AttackHitbox")
@onready var hitbox_shape: CollisionShape2D = hitbox.get_node("CollisionShape2D")

const HIT_FRAME_START := 3
const HIT_FRAME_END := 4
var has_attacked := false

func enter() -> void:
	has_attacked = false
	hitbox_shape.set_deferred("disabled", true)
	enemy.sprite.play("Attack")
	enemy.sprite.frame_changed.connect(_on_frame_changed)
	enemy.sprite.animation_finished.connect(_on_animation_finished)

func exit() -> void:
	if enemy.sprite.frame_changed.is_connected(_on_frame_changed):
		enemy.sprite.frame_changed.disconnect(_on_frame_changed)
	if enemy.sprite.animation_finished.is_connected(_on_animation_finished):
		enemy.sprite.animation_finished.disconnect(_on_animation_finished)
	hitbox_shape.set_deferred("disabled", true)

func physics_update(delta: float) -> void:
	enemy.velocity.x = 0
	enemy.velocity.y += 900 * delta
	enemy.move_and_slide()

func _on_frame_changed() -> void:
	var frame := enemy.sprite.frame
	hitbox_shape.disabled = frame < HIT_FRAME_START or frame > HIT_FRAME_END
	print("Frame: ", frame, " | disabled: ", hitbox_shape.disabled)
	
func _on_animation_finished() -> void:
	if enemy.target and enemy.global_position.distance_to(enemy.target.global_position) <= enemy.attack_range:
		enemy.sprite.play("Attack")
	else:
		state_machine.change_state(enemy.states["Chase"])

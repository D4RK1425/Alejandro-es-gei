extends State

@onready var boss: BossDemonSlime = owner
@onready var hitbox: Area2D = boss.get_node("AttackHitbox")
@onready var hitbox_shape: CollisionShape2D = hitbox.get_node("CollisionShape2D")

const HIT_FRAME_START := 6
const HIT_FRAME_END := 8
const HITBOX_OFFSET_X := 100.0

func enter() -> void:
	hitbox_shape.set_deferred("disabled", true)
	_update_hitbox_direction()
	boss.sprite.play("DemonCleave")
	boss.sprite.frame_changed.connect(_on_frame_changed)
	boss.sprite.animation_finished.connect(_on_animation_finished)

func exit() -> void:
	if boss.sprite.frame_changed.is_connected(_on_frame_changed):
		boss.sprite.frame_changed.disconnect(_on_frame_changed)
	if boss.sprite.animation_finished.is_connected(_on_animation_finished):
		boss.sprite.animation_finished.disconnect(_on_animation_finished)

func physics_update(delta: float) -> void:
	boss.velocity.x = 0
	boss.velocity.y += 900 * delta
	boss.move_and_slide()

func _update_hitbox_direction() -> void:
	hitbox.position.x = HITBOX_OFFSET_X * (1 if boss.sprite.flip_h else -1)

func _on_frame_changed() -> void:
	var frame: int = boss.sprite.frame
	hitbox_shape.disabled = frame < HIT_FRAME_START or frame > HIT_FRAME_END

func _on_animation_finished() -> void:
	if boss.target and boss.global_position.distance_to(boss.target.global_position) <= boss.attack_range:
		boss.sprite.play("DemonCleave")
	else:
		state_machine.change_state(boss.states["DemonChase"])

extends State

@onready var enemy: EnemyBase = owner
@onready var hitbox: Area2D = enemy.get_node("AttackHitbox")
@onready var hitbox_shape: CollisionShape2D = hitbox.get_node("CollisionShape2D")

const HIT_FRAME_START := 2
const HIT_FRAME_END := 3
var has_exploded := false

func enter() -> void:
	has_exploded = false
	hitbox_shape.set_deferred("disabled", true)
	enemy.velocity = Vector2.ZERO
	enemy.sprite.play("Explode")
	enemy.sprite.frame_changed.connect(_on_frame_changed)
	enemy.sprite.animation_finished.connect(_on_animation_finished)

func exit() -> void:
	if enemy.sprite.frame_changed.is_connected(_on_frame_changed):
		enemy.sprite.frame_changed.disconnect(_on_frame_changed)
	if enemy.sprite.animation_finished.is_connected(_on_animation_finished):
		enemy.sprite.animation_finished.disconnect(_on_animation_finished)

func physics_update(delta: float) -> void:
	pass  # se queda quieto explotando, no se mueve

func _on_frame_changed() -> void:
	var frame := enemy.sprite.frame
	hitbox_shape.disabled = frame < HIT_FRAME_START or frame > HIT_FRAME_END

func _on_animation_finished() -> void:
	enemy.queue_free()  # se autodestruye al terminar de explotar, sin vuelta a Idle/Chase

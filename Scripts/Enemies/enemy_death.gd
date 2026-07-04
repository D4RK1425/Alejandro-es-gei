extends State

@onready var enemy: EnemyBase = owner

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	enemy.sprite.play("Death")
	enemy.hurtbox.set_deferred("monitoring", false)
	enemy.attack_hitbox.set_deferred("monitoring", false)
	enemy.sprite.animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	enemy.queue_free()

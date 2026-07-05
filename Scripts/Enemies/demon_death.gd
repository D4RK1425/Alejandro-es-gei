extends State

@onready var boss: BossDemonSlime = owner

func enter() -> void:
	boss.velocity = Vector2.ZERO
	boss.sprite.play("DemonDeath")
	boss.hurtbox.set_deferred("monitoring", false)
	boss.attack_hitbox.set_deferred("monitoring", false)
	boss.sprite.animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	boss.queue_free()

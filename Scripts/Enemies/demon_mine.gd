# demon_mine.gd — en el piso, con gravedad
extends EnemyBase

func _ready() -> void:
	speed = 0.0
	damage = 20
	max_health = 10
	attack_range = 25.0
	detection_range = 25.0
	has_gravity = true
	death_animation_name = "Explode"
	super._ready()

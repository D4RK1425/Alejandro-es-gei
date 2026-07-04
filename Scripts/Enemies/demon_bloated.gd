# bloated_damned.gd
extends EnemyBase

func _ready() -> void:
	speed = 20.0
	damage = 25
	max_health = 15
	attack_range = 25.0
	detection_range = 100.0
	death_animation_name = "Explode"
	super._ready()

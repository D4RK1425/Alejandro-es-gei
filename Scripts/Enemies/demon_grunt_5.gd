# twisted_torso_damned.gd
extends EnemyBase

func _ready() -> void:
	speed = 25.0
	damage = 12
	max_health = 35
	attack_range = 25.0
	detection_range = 90.0
	super._ready()

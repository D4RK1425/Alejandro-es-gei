extends EnemyBase

func _ready() -> void:
	speed = 35.0
	damage = 8
	max_health = 25
	attack_range = 25
	detection_range = 100.0
	super._ready()

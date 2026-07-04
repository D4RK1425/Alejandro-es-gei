extends EnemyBase

func _ready() -> void:
	speed = 25.0
	damage = 18
	max_health = 100
	attack_range = 30.0
	detection_range = 130.0
	move_animation_name = "Move"
	can_be_interrupted = false
	super._ready()

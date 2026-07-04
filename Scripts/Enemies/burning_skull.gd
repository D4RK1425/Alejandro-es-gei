# burning_skull.gd — en el piso, con gravedad
extends EnemyBase

func _ready() -> void:
	speed = 60.0
	damage = 15
	max_health = 10
	attack_range = 25.0
	detection_range = 130.0
	death_animation_name = "Explode"
	super._ready()

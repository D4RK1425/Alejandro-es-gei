# demon_eye.gd — flota, sin gravedad
extends EnemyBase

func _ready() -> void:
	speed = 0.0  # no se mueve
	damage = 12
	max_health = 15
	attack_range = 25.0  # rango de detonación
	detection_range = 40.0  # igual al attack_range, ya que no persigue
	has_gravity = false
	death_animation_name = "Explode"
	super._ready()

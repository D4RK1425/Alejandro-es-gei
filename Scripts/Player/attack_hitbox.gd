extends Area2D

@export var damage: int = 50

func _ready() -> void:
	add_to_group("hitbox")

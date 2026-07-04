extends Area2D

@export var damage: int = 10

func _ready() -> void:
	add_to_group("hitbox")

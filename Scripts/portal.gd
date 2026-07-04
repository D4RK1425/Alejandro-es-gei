extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var is_open := false

func _ready() -> void:
	visible = false
	collision_shape.set_deferred("disabled", true)
	body_entered.connect(_on_body_entered)

func open() -> void:
	if is_open:
		return
	is_open = true
	visible = true
	sprite.play("Open")
	collision_shape.set_deferred("disabled", false)

func _on_body_entered(body: Node2D) -> void:
	if is_open and body.is_in_group("player"):
		GameManager.go_to_next_floor()

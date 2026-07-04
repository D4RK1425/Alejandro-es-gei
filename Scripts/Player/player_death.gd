extends State

@onready var player: CharacterBody2D = owner
@onready var visual: CharacterVisual = player.get_node("Visual")

func enter() -> void:
	visual.play("Death")
	player.velocity = Vector2.ZERO
	visual.body.animation_finished.connect(_on_animation_finished)

func exit() -> void:
	if visual.body.animation_finished.is_connected(_on_animation_finished):
		visual.body.animation_finished.disconnect(_on_animation_finished)

func physics_update(delta: float) -> void:
	player.velocity.y += player.GRAVITY * delta
	player.move_and_slide()

func _on_animation_finished() -> void:
	# aquí después conectamos pantalla de derrota / reinicio de piso
	pass

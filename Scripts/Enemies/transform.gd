extends State

@onready var boss: BossDemonSlime = owner
const TRANSFORM_DURATION := 1.2
var timer := 0.0

func enter() -> void:
	timer = TRANSFORM_DURATION
	boss.velocity = Vector2.ZERO
	boss.sprite.play("DemonIdle")
	_transform_effect()
	_resize_collision()

func _transform_effect() -> void:
	var original_y: float = boss.sprite.position.y
	boss.sprite.scale = Vector2(1.3, 1.3)
	boss.sprite.position.y = original_y - 55.0  # ajusta este número a ojo

	var tween := create_tween().set_loops(3)
	tween.tween_property(boss.sprite, "modulate", Color(1, 0.3, 0.3), 0.15)
	tween.tween_property(boss.sprite, "modulate", Color.WHITE, 0.15)

func physics_update(delta: float) -> void:
	boss.velocity.y += 900 * delta
	boss.move_and_slide()

	timer -= delta
	if timer <= 0:
		state_machine.change_state(boss.states["DemonIdle"])

func _resize_collision() -> void:
	boss.collision_shape.shape = boss.demon_shape
	boss.hurtbox_shape.shape = boss.demon_shape
	# ajusta también la posición Y si el demonio es más alto,
	# para que el pivote no quede "flotando" o hundido en el piso
	boss.collision_shape.position.y = -8  # ejemplo, ajusta a ojo

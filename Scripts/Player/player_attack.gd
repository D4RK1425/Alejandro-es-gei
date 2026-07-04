extends State

@onready var player: CharacterBody2D = owner
@onready var visual: CharacterVisual = player.get_node("Visual")
@onready var hitbox: Area2D = player.get_node("AttackHitbox")
@onready var hitbox_shape: CollisionShape2D = hitbox.get_node("CollisionShape2D")

var combo_step := 0
var queued_next_attack := false
const MAX_COMBO_STEPS := 3
const HIT_FRAME_START := 3
const HIT_FRAME_END := 4
const HITBOX_OFFSET_X := 20.0

func enter() -> void:
	combo_step = 0
	queued_next_attack = false
	visual.body.animation_finished.connect(_on_animation_finished)
	visual.body.frame_changed.connect(_on_frame_changed)
	_start_attack()

func exit() -> void:
	if visual.body.animation_finished.is_connected(_on_animation_finished):
		visual.body.animation_finished.disconnect(_on_animation_finished)
	if visual.body.frame_changed.is_connected(_on_frame_changed):
		visual.body.frame_changed.disconnect(_on_frame_changed)
	hitbox_shape.set_deferred("disabled", true)

func physics_update(delta: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.velocity.y += player.GRAVITY * delta
	player.move_and_slide()

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		queued_next_attack = true

func _start_attack() -> void:
	hitbox_shape.set_deferred("disabled", true)
	_update_hitbox_direction()
	visual.play("Attack")
	visual.body.speed_scale = 1.0 + (combo_step * 0.15)

func _update_hitbox_direction() -> void:
	hitbox.position.x = HITBOX_OFFSET_X * (1 if visual.body.flip_h else -1)

func _on_frame_changed() -> void:
	var frame := visual.body.frame
	hitbox_shape.disabled = frame < HIT_FRAME_START or frame > HIT_FRAME_END

func _on_animation_finished() -> void:
	if queued_next_attack and combo_step < MAX_COMBO_STEPS - 1:
		combo_step += 1
		queued_next_attack = false
		_start_attack()
	else:
		visual.body.speed_scale = 1.0
		state_machine.change_state(player.states["Idle"])

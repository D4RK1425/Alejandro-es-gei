class_name BossDemonSlime
extends CharacterBody2D

@export var slime_speed: float = 20.0
@export var demon_speed: float = 50.0
@export var demon_damage: int = 20
@export var max_health: int = 200
@export var detection_range: float = 150.0
@export var attack_range: float = 80.0
@export var invulnerability_time: float = 0.3

var states: Dictionary = {}
var target: Node2D = null
var last_hit_direction := 0
var is_dead := false
var is_invulnerable := false
var is_transformed := false

var slime_shape := CapsuleShape2D.new()
var demon_shape := CapsuleShape2D.new()

@onready var state_machine: StateMachine = $StateMachine
@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer
@onready var hurtbox: Area2D = $Hurtbox
@onready var attack_hitbox: Area2D = $AttackHitbox
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var hurtbox_shape: CollisionShape2D = $Hurtbox/CollisionShape2D

func _ready() -> void:
	add_to_group("enemy")
	health_component.max_health = max_health

	slime_shape.radius = 12.0
	slime_shape.height = 20.0

	demon_shape.radius = 18.0
	demon_shape.height = 40.0

	for child in state_machine.get_children():
		if child is State:
			states[child.name] = child

	health_component.died.connect(_on_died)
	health_component.health_changed.connect(_on_health_changed)
	invulnerability_timer.timeout.connect(_on_invulnerability_timeout)

func _on_health_changed(current: int, max_hp: int) -> void:
	if not is_transformed and current <= max_hp * 0.5:
		is_transformed = true
		state_machine.change_state(states["Transform"])

func _on_died() -> void:
	if is_dead:
		return
	is_dead = true
	state_machine.change_state(states["DemonDeath"])

func take_hit(from_position: Vector2) -> void:
	if is_dead or is_invulnerable:
		return
	if state_machine.current_state == states.get("Transform"):
		return

	last_hit_direction = sign(global_position.x - from_position.x)
	is_invulnerable = true
	invulnerability_timer.start(invulnerability_time)

	var hurt_state: String = "DemonHurt" if is_transformed else "SlimeHurt"
	if states.has(hurt_state):
		state_machine.change_state(states[hurt_state])

func _on_invulnerability_timeout() -> void:
	is_invulnerable = false

func face_target() -> void:
	if target:
		sprite.flip_h = target.global_position.x > global_position.x

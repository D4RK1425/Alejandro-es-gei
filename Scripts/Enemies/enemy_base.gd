class_name EnemyBase
extends CharacterBody2D

@export var speed: float = 40.0
@export var max_health: int = 30
@export var damage: int = 8
@export var detection_range: float = 120.0
@export var attack_range: float = 20
@export var invulnerability_time: float = 0.3
@export var attack_state_name: String = "Attack"
@export var death_animation_name: String = "Death"
@export var has_gravity: bool = true
@export var move_animation_name: String = "Walk"

var states: Dictionary = {}
var target: Node2D = null
var last_hit_direction := 0
var is_dead := false
var is_invulnerable := false

@onready var state_machine: StateMachine = $StateMachine
@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer
@onready var hurtbox: Area2D = $Hurtbox
@onready var attack_hitbox: Area2D = $AttackHitbox
@export var can_be_interrupted: bool = true

func _ready() -> void:
	add_to_group("enemy")
	health_component.max_health = max_health

	for child in state_machine.get_children():
		if child is State:
			states[child.name] = child

	health_component.died.connect(_on_died)
	invulnerability_timer.timeout.connect(_on_invulnerability_timeout)

func _on_died() -> void:
	if is_dead:
		return
	is_dead = true
	if states.has("Death"):
		state_machine.change_state(states["Death"])

func take_hit(from_position: Vector2) -> void:
	if is_dead or is_invulnerable:
		return
	if not states.has("Hurt"):
		return
	if not can_be_interrupted and state_machine.current_state == states.get("Attack"):
		return

	last_hit_direction = sign(global_position.x - from_position.x)
	is_invulnerable = true
	invulnerability_timer.start(invulnerability_time)
	state_machine.change_state(states["Hurt"])

func _on_invulnerability_timeout() -> void:
	is_invulnerable = false

func face_target() -> void:
	if target:
		sprite.flip_h = target.global_position.x > global_position.x

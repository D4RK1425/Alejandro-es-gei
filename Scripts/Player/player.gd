extends CharacterBody2D

const SPEED := 120.0
const RUN_SPEED := 200.0
const JUMP_VELOCITY := -300.0
const GRAVITY := 800.0
const INVULNERABILITY_TIME := 0.5

var states: Dictionary = {}
var last_hit_direction := 0
var is_dead := false
var is_invulnerable := false

@onready var state_machine: StateMachine = $StateMachine
@onready var health_component: HealthComponent = $HealthComponent
@onready var visual: CharacterVisual = $Visual
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer

func _ready() -> void:
	add_to_group("player")
	for child in state_machine.get_children():
		if child is State:
			states[child.name] = child

	health_component.died.connect(_on_died)
	health_component.health_changed.connect(_on_health_changed)
	invulnerability_timer.timeout.connect(_on_invulnerability_timeout)

func _on_died() -> void:
	if is_dead:
		return
	is_dead = true
	state_machine.change_state(states["Death"])

func _on_health_changed(current: int, max: int) -> void:
	# aquí luego conectamos la barra de vida del HUD
	pass

func take_hit(from_position: Vector2) -> void:
	print("take_hit llamado, states tiene Hurt: ", states.has("Hurt"))
	last_hit_direction = sign(global_position.x - from_position.x)
	if states.has("Hurt") and state_machine.current_state != states["Death"]:
		state_machine.change_state(states["Hurt"])

	last_hit_direction = sign(global_position.x - from_position.x)
	is_invulnerable = true
	invulnerability_timer.start(INVULNERABILITY_TIME)
	state_machine.change_state(states["Hurt"])

func _on_invulnerability_timeout() -> void:
	is_invulnerable = false

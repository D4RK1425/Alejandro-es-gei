extends Area2D

@export var health_component: HealthComponent

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	print("Área detectada: ", area.name, " grupos: ", area.get_groups())
	if not area.is_in_group("hitbox"):
		return
	

	var owner_node := get_owner()
	if owner_node.has_method("is_invulnerable") or ("is_invulnerable" in owner_node and owner_node.is_invulnerable):
		return

	health_component.take_damage(area.damage)
	var attacker := area.get_owner()
	if owner_node.has_method("take_hit"):
		owner_node.take_hit(attacker.global_position)
		print("owner_node: ", owner_node, " tiene take_hit: ", owner_node.has_method("take_hit"))

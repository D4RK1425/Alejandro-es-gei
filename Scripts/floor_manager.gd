class_name FloorManager
extends Node

@export var enemies_container: NodePath
@export var portal: NodePath

var enemy_count: int = 0

func _ready() -> void:
	var container := get_node(enemies_container)
	var portal_node := get_node(portal)

	enemy_count = container.get_child_count()

	if enemy_count == 0:
		portal_node.open()
		return

	for enemy in container.get_children():
		enemy.tree_exited.connect(_on_enemy_removed.bind(portal_node))

func _on_enemy_removed(portal_node: Node) -> void:
	enemy_count -= 1
	if enemy_count <= 0:
		portal_node.open()

# game_manager.gd
extends Node

var current_floor: int = 1

var floor_scenes: Array[String] = [
	"res://scenes/floors/piso_1.tscn",
	"res://scenes/floors/piso_2.tscn",
	"res://scenes/floors/piso_3.tscn",
	"res://scenes/floors/piso_4.tscn",
	"res://scenes/floors/piso_5.tscn",
]

func go_to_next_floor() -> void:
	current_floor += 1
	if current_floor > floor_scenes.size():
		get_tree().change_scene_to_file("res://scenes/ui/Victory.tscn")
		return
	get_tree().change_scene_to_file(floor_scenes[current_floor - 1])

func go_to_floor(floor_number: int) -> void:
	current_floor = floor_number
	get_tree().change_scene_to_file(floor_scenes[current_floor - 1])

func restart_current_floor() -> void:
	get_tree().change_scene_to_file(floor_scenes[current_floor - 1])

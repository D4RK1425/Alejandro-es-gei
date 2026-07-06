extends Control

@export_file("*.tscn") var first_level_path: String = "res://Scenes/Floors/piso_1.tscn"

@export var controls_panel_path: NodePath
@export var credits_panel_path: NodePath
@export var configuration_panel_path: NodePath

@onready var controls_panel: Control = get_node_or_null(controls_panel_path)
@onready var credits_panel: Control = get_node_or_null(credits_panel_path)
@onready var configuration_panel: Control = get_node_or_null(configuration_panel_path)

@onready var button_click_sound: AudioStreamPlayer = $ButtonClickSound


func _ready():
	_hide_all_panels()


func play_button_sound():
	if button_click_sound:
		button_click_sound.play()


func _on_iniciar_pressed():
	play_button_sound()
	get_tree().change_scene_to_file(first_level_path)


func _on_controles_pressed():
	play_button_sound()
	_hide_all_panels()
	
	if controls_panel:
		controls_panel.visible = true


func _on_configuracion_pressed():
	play_button_sound()
	_hide_all_panels()
	
	if configuration_panel:
		configuration_panel.visible = true


func _on_creditos_pressed():
	play_button_sound()
	_hide_all_panels()
	
	if credits_panel:
		credits_panel.visible = true


func _on_salir_pressed():
	play_button_sound()
	get_tree().quit()


func _on_volver_pressed():
	play_button_sound()
	_hide_all_panels()


func _hide_all_panels():
	if controls_panel:
		controls_panel.visible = false
	
	if credits_panel:
		credits_panel.visible = false
	
	if configuration_panel:
		configuration_panel.visible = false

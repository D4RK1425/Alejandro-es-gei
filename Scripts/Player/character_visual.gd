class_name CharacterVisual
extends Node2D

@onready var body: AnimatedSprite2D = $BodySprite
@onready var layers: Array[AnimatedSprite2D] = [
	$BootsSprite,
	$PantsSprite,
	$ShirtSprite,
	$HairSprite,
	$WeaponSprite,
]

func _ready() -> void:
	body.frame_changed.connect(_sync_frame)
	body.animation_changed.connect(_sync_animation)

func play(anim_name: String) -> void:
	if body.animation == anim_name and body.is_playing():
		return
	body.play(anim_name)
	for layer in layers:
		if not layer.sprite_frames.has_animation(anim_name):
			push_error("Falta la animación '" + anim_name + "' en: " + layer.name)
			continue
		layer.play(anim_name)

func set_flip(flip: bool) -> void:
	body.flip_h = flip
	for layer in layers:
		layer.flip_h = flip

func flash() -> void:
	var all_sprites: Array[AnimatedSprite2D] = [body]
	all_sprites.append_array(layers)

	var tween := create_tween().set_parallel(true)
	for sprite in all_sprites:
		sprite.modulate = Color(1, 0.4, 0.4)
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.15)
		
func _sync_animation() -> void:
	for layer in layers:
		layer.animation = body.animation

func _sync_frame() -> void:
	for layer in layers:
		layer.frame = body.frame

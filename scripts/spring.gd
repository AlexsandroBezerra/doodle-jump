extends "res://scripts/platform.gd"

onready var spring := get_node("spring_sprite")

func response():
	spring.play("default")

func _on_spring_sprite_animation_finished():
	spring.frame = 0
	spring.stop()

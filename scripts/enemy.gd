extends "res://scripts/platform.gd"

var direction := Vector2.RIGHT
var velocity := Vector2.ZERO
export var speed := 100

onready var screen_size := get_viewport_rect().size
onready var sprite := get_node("sprite")

func move(delta):
	velocity = direction * speed
	position += velocity * delta

func _process(delta):
	move(delta)

	if position.x >= screen_size.x:
		direction = Vector2.LEFT
		sprite.flip_h = !sprite.flip_h
	elif position.x < 0:
		direction = Vector2.RIGHT
		sprite.flip_h = !sprite.flip_h

func response():
	queue_free()

func _on_enemy_hitbox_body_entered(body: Node):
	if body.is_in_group("player"):
		if body.has_method("game_over"):
			body.game_over()
		else:
			print("Player does not have method 'game_over'")

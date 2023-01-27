extends KinematicBody2D

onready var sprite := get_node("sprite")
onready var screen_size := get_viewport_rect().size

export var GRAVITY := 10
export var SPEED := 200
export var jump_force := 400
export var acellerometer_range := 6

var velocity := Vector2.ZERO
var input_direction: float

func _physics_process(delta: float):
	move(delta)

	position.x = wrapf(position.x, 0, screen_size.x)

func move(delta: float):
	var accelerometer_x = Input.get_accelerometer().x
	var accelerometer_direction = clamp(accelerometer_x, -acellerometer_range, acellerometer_range) / acellerometer_range
	var axis_direction = Input.get_axis("ui_left", "ui_right")

	if accelerometer_direction != 0:
		input_direction = accelerometer_direction
	else:
		input_direction = axis_direction

	if input_direction != 0:
		velocity.x = lerp(velocity.x, input_direction * SPEED, 0.5)
		sprite.flip_h = input_direction > 0
	else:
		velocity.x = lerp(velocity.x, 0, 0.5)

	velocity.y += GRAVITY

	var collision = move_and_collide(velocity * delta)

	if velocity.y > 0:
		sprite.play("fall")
	else:
		sprite.play("idle")

	if collision:
		velocity.y = -jump_force * collision.collider.jump_force

		if collision.collider.has_method("response"):
			collision.collider.response()

func game_over():
	var _error = get_tree().reload_current_scene()

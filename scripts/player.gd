extends KinematicBody2D

onready var sprite := $sprite as AnimatedSprite
onready var screen_size := get_viewport_rect().size

const GRAVITY := 10
const JUMP_FORCE := 400
const SPEED := 200

var velocity := Vector2.ZERO

func move(delta: float):
	var input_direction = Input.get_axis("ui_left", "ui_right")
	
	if input_direction != 0:
		velocity.x = lerp(velocity.x, input_direction * SPEED, 0.5)
		sprite.scale.x = -input_direction
	else:
		velocity.x = lerp(velocity.x, 0, 0.5)
	
	velocity.y += GRAVITY
	
	var collision = move_and_collide(velocity * delta)
	
	if velocity.y > 0:
		sprite.play("fall")
	else:
		sprite.play("idle")
	
	if collision:
		velocity.y -= JUMP_FORCE
	
func _physics_process(delta: float):
	move(delta)
	
	position.x = wrapf(position.x, 0, screen_size.x)

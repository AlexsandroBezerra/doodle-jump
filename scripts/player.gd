extends KinematicBody2D

const GRAVITY := 10
const JUMP_FORCE := 400

var velocity := Vector2.ZERO

func move(delta: float):
	velocity.y += GRAVITY
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity.y -= JUMP_FORCE
	
func _physics_process(delta: float):
	move(delta)

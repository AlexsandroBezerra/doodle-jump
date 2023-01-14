extends StaticBody2D

export var jump_force := 0.0

func _on_notifier_screen_exited():
	queue_free()

extends "res://scripts/platform.gd"

func response():
	queue_free()


func _on_notifier_screen_exited():
	queue_free()

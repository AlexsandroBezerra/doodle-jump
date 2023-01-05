extends Node2D

onready var player := get_node("player")
onready var camera := get_node("camera")
onready var platform_container := get_node("platform_container")
onready var platform_y = get_node("platform_container/platform").position.y

export (Array, PackedScene) var platform_scene

func _ready():
	randomize()
	generate_platforms(15)

func _physics_process(_delta: float):
	if player.position.y < camera.position.y:
		camera.position.y = player.position.y

func generate_platforms(amount := 1):
	for items in amount:
		var new_type = rand_range(0, 3)
		var new_platform: StaticBody2D = platform_scene[new_type].instance()
		
		var platform_x = rand_range(20, 160)
		platform_y -= rand_range(36, 54)
		
		new_platform.position = Vector2(platform_x, platform_y)
		
		platform_container.call_deferred("add_child", new_platform)

func _on_platform_cleaner_body_entered(body: Node):
	if body.name == "player":
		game_over()
	
	generate_platforms()
	body.queue_free()

func game_over():
	print("Game over!")
	var _error = get_tree().reload_current_scene()

extends Node2D

onready var player := get_node("player")
onready var camera := get_node("camera")
onready var score_label := get_node("ui/score")
onready var platform_container := get_node("platforms_container")
onready var platform_y = get_node("platforms_container/platform").position.y
onready var camera_initial_y = camera.position.y

const DEFAULT_PLATFORM_INDEX = -1

var last_platform_variation := DEFAULT_PLATFORM_INDEX

export (PackedScene) var default_platform
export (Array, PackedScene) var platform_variations

var score = 0

func _ready():
	randomize()
	generate_platforms(15)

func _physics_process(_delta: float):
	score_update()

	if player.position.y < camera.position.y:
		camera.position.y = player.position.y

func generate_platforms(amount := 1):
	for items in amount:
		var is_variation := randi() % 2

		if is_variation == 1:
			var variation = randi() % platform_variations.size()

			if last_platform_variation == variation:
				generate_platform(default_platform.instance(), DEFAULT_PLATFORM_INDEX)
			else:
				generate_platform(platform_variations[variation].instance(), variation)
		else:
			generate_platform(default_platform.instance(), DEFAULT_PLATFORM_INDEX)

func generate_platform(platform: StaticBody2D, variation: int):
	var platform_x = rand_range(20, 160)
	platform_y -= rand_range(36, 54)

	platform.position = Vector2(platform_x, platform_y)

	platform_container.call_deferred("add_child", platform)
	last_platform_variation = variation

func score_update():
	score = int(camera_initial_y - camera.position.y)
	score_label.text = str(score)

func _on_platforms_container_child_exiting_tree(_node: Node):
	generate_platforms()

func _on_visibility_notifier_screen_exited():
	if player.has_method("game_over"):
		player.game_over()

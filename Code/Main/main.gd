extends Node2D

const OBSTACLE_LINE = preload("uid://cbyfk238wg2yl")
@onready var spawn_timer = $SpawnTimer

func _ready():
	spawn_timer.wait_time = randf_range(0.5, 5)
	spawn_timer.start()
	_spawn()

func _on_timer_timeout():
	spawn_timer.wait_time = randf_range(0.5, 5)
	spawn_timer.start()
	_spawn()

func _spawn():
	var obstacles = OBSTACLE_LINE.instantiate()
	obstacles.position = Vector2(340.0, -130.0)
	add_child(obstacles)

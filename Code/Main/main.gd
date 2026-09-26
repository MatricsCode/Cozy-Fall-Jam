extends Node2D

const OBSTACLE_LINE = preload("uid://cbyfk238wg2yl")

@onready var spawn_timer = $SpawnTimer

var counter = 0

func _ready():
	GlobalScript.start.connect(_start)
	GlobalScript.stop.connect(_stop)
	GlobalScript.lost.connect(_stop)

func _stop():
	spawn_timer.stop()
func _start():
	spawn_timer.wait_time = randf_range(1, 2)
	spawn_timer.start()


func _on_timer_timeout():
	spawn_timer.wait_time = randf_range(1, 2)
	spawn_timer.start()
	_spawn()

func _spawn():
	counter += 1
	
	var obstacles = OBSTACLE_LINE.instantiate()
	obstacles.position = Vector2(340.0, 0)
	if counter == 3:
		obstacles.vegtable = true
	add_child(obstacles)

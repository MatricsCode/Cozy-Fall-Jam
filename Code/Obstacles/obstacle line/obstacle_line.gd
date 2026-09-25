extends Node2D

const OBSTACLE_MAIN = preload("uid://bly3j20mkirc")

# Called when the node enters the scene tree for the first time.
func _ready():
	var count = 0
	while count < randi_range(3, 7):
		count += 1
		var obstacle = OBSTACLE_MAIN.instantiate()
		obstacle.position.y = randi_range(100, 1000)
		add_child(obstacle)
		

extends Node2D

const OBSTACLE_MAIN = preload("uid://bly3j20mkirc")

# Called when the node enters the scene tree for the first time.
func _ready():
	var count = 0
	var last_position = 0
	
	while count < randi_range(3, 7):
		count += 1
		var obstacle = OBSTACLE_MAIN.instantiate()
		last_position += randi_range(25, 150)
		obstacle.position.y = last_position
		add_child(obstacle)
		

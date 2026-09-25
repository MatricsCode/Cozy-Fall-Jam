extends Node

var current_direction = 1
var current_multiplier = 1
var current_speed = 1

func _physics_process(delta):
	var input = Input.get_axis("Left", "Right")
	
	if input == 0:
		current_direction = 2
	elif input == -1:
		current_direction = 1
	elif input == 1:
		current_direction = 4
	
	current_speed = current_direction * current_multiplier

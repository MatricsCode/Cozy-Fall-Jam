extends Node

var input_direction = Vector2.ZERO

func _physics_process(delta):
	input_direction = Input.get_vector("Right", "Left", "Up", "Down")

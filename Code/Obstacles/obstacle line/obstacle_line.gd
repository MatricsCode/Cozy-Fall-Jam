extends Node2D

func _physics_process(_delta):
	position.x -= GlobalScript.current_speed

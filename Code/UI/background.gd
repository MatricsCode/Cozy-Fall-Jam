extends Control

@onready var road1 = $TextureRect

func _physics_process(_delta):
	road1.position.x -= GlobalScript.current_speed
	
	if road1.position.x <= -640.0:
		road1.position.x = 0

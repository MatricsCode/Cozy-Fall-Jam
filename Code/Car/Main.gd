extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var speed_up = 2

func _physics_process(delta):
	if GlobalScript.input_direction.y != 0:
		velocity.y += GlobalScript.input_direction.y * speed_up * 0.01
		speed_up += speed_up * speed_up
		speed_up = clamp(speed_up,0,100)
	
	move_and_slide()

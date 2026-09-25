extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var speed_up = 0

func _physics_process(delta):
	if GlobalScript.input_direction.y != 0:
		velocity.y = GlobalScript.input_direction.y * 100 * speed_up
		speed_up += 0.1
		speed_up = clamp(speed_up, 0, 3)

	else:
		var slowdown = get_tree().create_tween()
		slowdown.tween_property(self, "velocity", Vector2.ZERO, 0.1)
		speed_up = 0
	
	move_and_slide()

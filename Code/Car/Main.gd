extends CharacterBody2D

var speed_up = Vector2.ZERO
var input_direction = Vector2.ZERO

func _physics_process(delta):
	
	input_direction = Input.get_vector("Left", "Right",  "Up", "Down")
	
	if input_direction.x != 0:
		velocity.x = input_direction.x * 100 * speed_up.x
		speed_up.x += 0.1
		speed_up.x = clamp(speed_up.x, 0, 2)
	else:
		#var slowdown = get_tree().create_tween()
		#slowdown.tween_property(self, "velocity", Vector2(0,velocity.y), 0.05)
		
		#var intermitten_velocity = velocity.x
		#var slowdown = get_tree().create_tween()
		#slowdown.tween_property(self, intermitten_velocity, 0, 0.1)
		speed_up.x = 0
		velocity.x *= 0.9
	
	if input_direction.y != 0:
		velocity.y = input_direction.y * 100 * speed_up.y
		speed_up.y += 0.1
		speed_up.y = clamp(speed_up.y, 0, 2)
	else:
		#var slowdown = get_tree().create_tween()
		#slowdown.tween_property(self, "velocity", Vector2(velocity.x, 0), 0.05)
		
		#var intermitten_velocity = velocity.x
		#var slowdown = get_tree().create_tween()
		#slowdown.tween_property(self, intermitten_velocity, 0, 0.1)
		speed_up.y = 0
		velocity.y  *= 0.9

	
	move_and_slide()

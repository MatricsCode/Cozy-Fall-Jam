extends CharacterBody2D

var speed_up = Vector2.ZERO
var input_direction = Vector2.ZERO

func _physics_process(delta):
	
	input_direction = Input.get_vector("Left", "Right",  "Up", "Down")
	
	if input_direction.x != 0:
		velocity = input_direction.x * 100 * speed_up.x
		speed_up.x += 0.1
		speed_up.x = clamp(speed_up.x, 0, 2)
	else:
		#var intermitten_velocity = velocity.x
		#var slowdown = get_tree().create_tween()
		#slowdown.tween_property(self, intermitten_velocity, 0, 0.1)
		speed_up.x = 0
		velocity.x = 0 #intermitten_velocity
	
	if input_direction.y != 0:
		velocity = input_direction.y * 100 * speed_up.y
		speed_up.y += 0.05
		speed_up.y = clamp(speed_up.x, 0, 1)
	else:
		#var intermitten_velocity = velocity.y
		#var slowdown = get_tree().create_tween()
		#slowdown.tween_property(self, intermitten_velocity, 0, 0.1)
		speed_up.y = 0
		velocity.y = 0#intermitten_velocity

	
	move_and_slide()

extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var forwards = $Forwards
@onready var downwards = $Downwards
@onready var upwards = $Upwards

enum Direction {FORWARDS, UPWARDS, DOWNWARDS}

var current_direction = Direction.FORWARDS

var speed_up = Vector2.ZERO
var input_direction = Vector2.ZERO

func _physics_process(delta):
	
	_movement()
	_turning()
	
	move_and_slide()

func _movement():
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
		
		if input_direction.y == -1:
			current_direction = Direction.UPWARDS
		else:
			current_direction = Direction.DOWNWARDS
	else:
		#var slowdown = get_tree().create_tween()
		#slowdown.tween_property(self, "velocity", Vector2(velocity.x, 0), 0.05)
		
		#var intermitten_velocity = velocity.x
		#var slowdown = get_tree().create_tween()
		#slowdown.tween_property(self, intermitten_velocity, 0, 0.1)
		
		current_direction = Direction.FORWARDS
		
		speed_up.y = 0
		velocity.y  *= 0.9

func _turning():
	if current_direction == Direction.FORWARDS:
		sprite.play("forwards")
		forwards.position.y = 0
		downwards.position.y = 1000000
		upwards.position.y = 10000
	elif current_direction == Direction.DOWNWARDS:
		sprite.play("downwards")
		forwards.position.y = 1000000
		downwards.position.y = 0
		upwards.position.y = 10000
	elif current_direction == Direction.UPWARDS:
		sprite.play("upwards")
		forwards.position.y = 1000000
		downwards.position.y = 10000
		upwards.position.y = 0

func _on_hit_area_body_entered(body):
	queue_free()

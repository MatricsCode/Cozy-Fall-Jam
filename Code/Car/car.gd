extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D


enum Direction {FORWARDS, UPWARDS, DOWNWARDS}

var current_direction = Direction.FORWARDS

var speed_up = Vector2.ZERO
var input_direction = Vector2.ZERO

var moving = false

func _ready():
	GlobalScript.start.connect(_start_driving)
	GlobalScript.stop.connect(_stop_driving)
	GlobalScript.lost.connect(_stop_driving)

func _physics_process(_delta):
	input_direction = Input.get_vector("Left", "Right",  "Up", "Down")
	
	if moving:
		_movement()
		_turning()
	
	move_and_slide()

func _movement():
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
func _turning():
	if input_direction.y < 0 and input_direction.x >= 0:
		current_direction = Direction.UPWARDS
	elif input_direction.y < 0 and input_direction.x < 0:
		current_direction = Direction.DOWNWARDS
	
	if input_direction.y > 0 and input_direction.x >= 0:
		current_direction = Direction.DOWNWARDS
	elif input_direction.y > 0 and input_direction.x < 0:
		current_direction = Direction.UPWARDS
	
	if input_direction.y == 0:
		current_direction = Direction.FORWARDS

	if current_direction == Direction.FORWARDS:
		sprite.play("forwards")
		$"ForwardCollision".position.y = 0
		$"ForwardHitArea".position.y  = 0
		$"UpwardCollision".position.y = 10000
		$"UpwardHitArea".position.y = 10000
		$"DownwardCollision".position.y = 10000 
		$"DownwardHitArea".position.y = 10000
	elif current_direction == Direction.UPWARDS:
		sprite.play("upwards")
		$"ForwardCollision".position.y = 10000
		$"ForwardHitArea".position.y  = 10000
		$"UpwardCollision".position.y = 0
		$"UpwardHitArea".position.y = 0
		$"DownwardCollision".position.y = 10000 
		$"DownwardHitArea".position.y = 10000
	elif current_direction == Direction.DOWNWARDS:
		sprite.play("downwards")
		$"ForwardCollision".position.y = 10000
		$"ForwardHitArea".position.y  = 10000
		$"UpwardCollision".position.y = 10000
		$"UpwardHitArea".position.y = 10000
		$"DownwardCollision".position.y = 0
		$"DownwardHitArea".position.y = 0

func _on_hit_area_body_entered(body):
	body.get_parent()._hit()
	_lose()

func _lose():
	GlobalScript.lost.emit()
	sprite.play("forwards")
	var lose = get_tree().create_tween()
	lose.tween_property(self, "position", Vector2(200, -75), 1)
func _start_driving():
	moving = true
func _stop_driving():
	moving = false

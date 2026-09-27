extends TextureRect

@onready var label = $Label

var counter = -1

var saftey_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.start.connect(_start)
	GlobalScript.lost.connect(_stop)
	GlobalScript.stop.connect(_stop)
	
	GlobalScript.new_recipe.connect(_increase_number)
	
	saftey_position = position 
	position.x -= 500

func _increase_number():
	counter += 1
	label.text = str(counter, "x")

func _start():
	var starter = get_tree().create_tween()
	
	starter.set_parallel(true)
	
	starter.tween_property(self, "position", saftey_position, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	starter.tween_property(self, "scale", Vector2(1,1), 1.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)

func _stop():
	var stopper = get_tree().create_tween()
	
	stopper.set_parallel(true)
	
	stopper.tween_property(self, "position", Vector2(saftey_position.x - 500, saftey_position.y), 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	stopper.tween_property(self, "scale", Vector2.ZERO, 1.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	
	await stopper.finished
	
	counter = -1

func _on_mouse_entered():
	var excited = get_tree().create_tween()
	excited.set_parallel(true)
	
	excited.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	
	await excited.finished
	
	excited.kill()
	
	excited = get_tree().create_tween()
	excited.set_parallel(true)
	
	excited.tween_property(self, "scale", Vector2(1.1,1.1), 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
func _on_mouse_exited():
	var excited = get_tree().create_tween()
	excited.set_parallel(true)
	
	excited.tween_property(self, "scale", Vector2(0.75,0.75), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	
	await excited.finished
	
	excited.kill()
	
	excited = get_tree().create_tween()
	excited.set_parallel(true)
	
	excited.tween_property(self, "scale", Vector2(1,1), 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)

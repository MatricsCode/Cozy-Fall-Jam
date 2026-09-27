extends Control

@onready var clock_body = $ClockBody
@onready var clock_handle = $ClockHandle
@onready var time_label = $Label
@onready var timer = $Timer

var time_left = 0
var time_playing = 0.0

var saftey_position : Vector2

func _on_timer_timeout():
	GlobalScript.increase_mult.emit(time_left / 1000.0)
	
	time_playing += 1
	time_left -= 1
	time_label.text = str(time_left, " sec")
	if time_left <= 0:
		GlobalScript.stop.emit()
	clock_handle.rotation_degrees += 45

func _ready():
	GlobalScript.start.connect(_start)
	GlobalScript.lost.connect(_stop)
	GlobalScript.stop.connect(_stop)
	
	GlobalScript.new_recipe.connect(_more_time)
	
	saftey_position = position 
	position.x -= 500

func _start():
	visible = true
	var starter = get_tree().create_tween()
	
	starter.set_parallel(true)
	
	starter.tween_property(self, "position", saftey_position, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	starter.tween_property(self, "scale", Vector2(1,1), 1.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	
	await starter.finished
	
	
	time_playing = 0
	time_left = 30
	time_label.text = str(time_left, " sec")
	timer.start()
func _stop():
	var stopper = get_tree().create_tween()
	
	stopper.set_parallel(true)
	
	stopper.tween_property(self, "position", Vector2(saftey_position.x - 500, saftey_position.y), 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	stopper.tween_property(self, "scale", Vector2.ZERO, 1.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	
	await stopper.finished
	
	time_label.text = ""
	timer.stop()
	
	visible = false
func _more_time():
	if GlobalScript.recipes_finished.size() == 0:
		return
	
	var multiplier = GlobalScript.recipes_finished.get(GlobalScript.recipes_finished.size()-1).size()
	time_left += 2 * multiplier
	time_label.text = str(time_left, " sec")
	timer.stop()
	for i in multiplier:
		await get_tree().create_timer(0.1).timeout
		clock_handle.rotation_degrees -= 45
	timer.start()

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

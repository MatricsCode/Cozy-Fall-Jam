extends Control

@onready var clock_body = $ClockBody
@onready var clock_handle = $ClockHandle
@onready var time_label = $Label
@onready var timer = $Timer

var time_left = 0
var time_playing = 0

var saftey_position : Vector2

func _on_timer_timeout():
	time_left -= 1
	time_label.text = str(time_left, " sec")
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
	timer.start()

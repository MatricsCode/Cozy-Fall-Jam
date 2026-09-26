extends Control

@onready var time_label = $Label
@onready var timer = $Timer

var time_left = 0

func _ready():
	GlobalScript.start.connect(_starting)
	GlobalScript.stop.connect(_stoping)
	GlobalScript.lost.connect(_stoping)
	GlobalScript.new_recipe.connect(_more_time)

func _starting():
	time_left = 120
	time_label.text = str("Time Left: ", time_left, " sec")
	timer.start()
func _stoping():
	time_label.text = ""
	timer.stop()
func _more_time():
	if GlobalScript.recipes_finished.size() == 0:
		return
	
	var multiplier = GlobalScript.recipes_finished.get(GlobalScript.recipes_finished.size()-1).size()
	time_left += 5 * multiplier
	time_label.text = str("Time Left: ", time_left, " sec")
	timer.stop()
	timer.start()

func _on_timer_timeout():
	timer.start()
	time_left -= 1
	
	time_label.text = str("Time Left: ", time_left, " sec")
	
	if time_left <= 0:
		GlobalScript.stop.emit()

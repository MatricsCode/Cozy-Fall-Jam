extends Control

@onready var start = $Main/Control/Start

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.start.connect(_starting_new_run)
	GlobalScript.stop.connect(_stoping_run)
	GlobalScript.lost.connect(_stoping_run)

func _starting_new_run():
	visible = false

func _stoping_run():
	visible = true
	start._spawn_in()

func _on_start_pressed():
	GlobalScript._start_run()

func _on_settings_pressed():
	pass # Replace with function body.

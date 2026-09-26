extends Control

func _ready():
	$VBoxContainer/Start._spawn_in()
	$VBoxContainer/Settings._spawn_in() 
	$VBoxContainer/Quit._spawn_in()

func _on_start_pressed():
	
	GlobalScript._start_run()
	queue_free()

func _on_settings_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()

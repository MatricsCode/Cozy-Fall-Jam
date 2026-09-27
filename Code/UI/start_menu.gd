extends Control

@onready var control = $"../Control"

func _ready():
	$VBoxContainer/Start._spawn_in()
	$VBoxContainer/Settings._spawn_in() 
	control.get_child(3).pressed.connect(_on_start_pressed)

func _on_start_pressed():
	
	GlobalScript._start_run()
	
	var spawn_in = get_tree().create_tween()
	spawn_in.set_parallel(true)
	
	spawn_in.tween_property(control, "position", Vector2(1000,-1000), 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	spawn_in.tween_property(control, "scale", Vector2(0,0), 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	
	control.queue_free()
	queue_free()

func _on_settings_pressed():
	control.scale = Vector2.ZERO
	control.position = Vector2(randf_range(-25, 25),randf_range(-25, 25))
	
	control.visible = true
	
	var spawn_in = get_tree().create_tween()
	spawn_in.set_parallel(true)
	
	spawn_in.tween_property(control, "position", Vector2(0,0), 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	spawn_in.tween_property(control, "scale", Vector2(1,1), 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	spawn_in.tween_property(self, "position", Vector2(1000,-1000), 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	spawn_in.tween_property(self, "scale", Vector2(0,0), 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	
	

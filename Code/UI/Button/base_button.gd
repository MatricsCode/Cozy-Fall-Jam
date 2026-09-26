extends Button

var saftey_position : Vector2

# Called when the node enters the scene tree for the first time.
func _spawn_in():
	self_modulate.a = 0
	
	pivot_offset = Vector2(size.x/2, size.y/2)
	
	await get_tree().create_timer(0.2).timeout
	
	var rand_mult = randi_range(-1,1)
	while rand_mult == 0:
		rand_mult = randi_range(-1,1)
	
	saftey_position = position
	
	position.x += 100 * rand_mult
	position.y += 50 * rand_mult
	
	scale = Vector2(0,0)
	
	
	var spawn_in = get_tree().create_tween()
	spawn_in.set_parallel(true)
	
	spawn_in.tween_property(self, "position", saftey_position, 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	spawn_in.tween_property(self, "scale", Vector2(1,1), 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	spawn_in.tween_property(self, "self_modulate", Color.WHITE, 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)

func _on_mouse_entered():
	var excited = get_tree().create_tween()
	excited.set_parallel(true)
	
	excited.tween_property(self, "position", Vector2(saftey_position.x, saftey_position.y - 5), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	excited.tween_property(self, "scale", Vector2(1.2,1.2), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	
	await excited.finished
	
	excited.kill()
	
	excited = get_tree().create_tween()
	excited.set_parallel(true)
	
	excited.tween_property(self, "position", saftey_position, 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	excited.tween_property(self, "scale", Vector2(1.1,1.1), 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
func _on_mouse_exited():
	var excited = get_tree().create_tween()
	excited.set_parallel(true)
	
	excited.tween_property(self, "position", Vector2(saftey_position.x, saftey_position.y + 10), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	excited.tween_property(self, "scale", Vector2(0.75,0.75), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	
	await excited.finished
	
	excited.kill()
	
	excited = get_tree().create_tween()
	excited.set_parallel(true)
	
	print(position.y, saftey_position.y)
	
	excited.tween_property(self, "position", Vector2(saftey_position.x, saftey_position.y), 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	excited.tween_property(self, "scale", Vector2(1,1), 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)

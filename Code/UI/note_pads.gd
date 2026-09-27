extends TextureRect

const BEETROOT = preload("uid://dubebsniedxk3")
const CARROT = preload("uid://bv8wcd35unlgx")
const POTATO = preload("uid://blptbb5xkblaw")
const ONION = preload("uid://ddt1np16v7ftx")
const TURNIP = preload("uid://ck4x7w3v6hwgr")

const BEETROOT_GHOST = preload("uid://dtjkc1mfn1kly")
const CARROT_GHOST = preload("uid://ck2q54axw5ywh")
const ONION_GHOST = preload("uid://dp3ckwv1dtmay")
const POTATO_GHOST = preload("uid://bggft0q1w7tmm")
const TURNIP_GHOST = preload("uid://bg3icl6fvbeei")

var wait_time

var points = 0

var texture_rects = []

var safe_position

signal finished

# Called when the node enters the scene tree for the first time.
func _ready():
	self_modulate.a = 0
	scale = Vector2(0,0)
	
	
	var spawn_in = get_tree().create_tween()
	spawn_in.set_parallel(true)
	
	spawn_in.tween_property(self, "scale", Vector2(1,1), 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	spawn_in.tween_property(self, "self_modulate", Color.WHITE, 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	
	texture_rects = [$Icons/HBoxContainer/TextureRect, 
		$Icons/HBoxContainer/TextureRect2, 
		$Icons/HBoxContainer/TextureRect3, 
		$Icons/HBoxContainer2/TextureRect, 
		$Icons/HBoxContainer2/TextureRect2, 
		$Icons/HBoxContainer2/TextureRect3]
	
	var current_array : Array
	current_array.append_array(GlobalScript.recipes_finished[GlobalScript.get_child_count()-1])
	
	points = current_array.size()
	
	for i in current_array.size():
		
		match current_array[i]:
			1:
				texture_rects.get(i).texture = BEETROOT_GHOST
			2:
				texture_rects.get(i).texture = CARROT_GHOST
			3:
				texture_rects.get(i).texture = POTATO_GHOST
			4:
				texture_rects.get(i).texture = ONION_GHOST
			5:
				texture_rects.get(i).texture = TURNIP_GHOST
	
	await spawn_in.finished
	
	for i in current_array.size():
		var squash = get_tree().create_tween()
		
		squash.tween_property(texture_rects.get(i), "scale", Vector2(0.7,0.7), wait_time/2)
		
		match current_array[i]:
			1:
				texture_rects.get(i).texture = BEETROOT
			2:
				texture_rects.get(i).texture = CARROT
			3:
				texture_rects.get(i).texture = POTATO
			4:
				texture_rects.get(i).texture = ONION
			5:
				texture_rects.get(i).texture = TURNIP
		
		await get_tree().create_timer(wait_time/2).timeout
		
		squash.kill()
		squash = get_tree().create_tween()
		squash.tween_property(texture_rects.get(i), "scale", Vector2(1,1), wait_time/2)
	
	
	
	finished.emit()

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

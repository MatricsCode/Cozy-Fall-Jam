extends TextureRect

const BEETROOT_GHOST = preload("uid://dtjkc1mfn1kly")
const CARROT_GHOST = preload("uid://ck2q54axw5ywh")
const POTATO_GHOST = preload("uid://bggft0q1w7tmm")
const ONION_GHOST = preload("uid://dp3ckwv1dtmay")
const TURNIP_GHOST = preload("uid://bg3icl6fvbeei")

const BEETROOT = preload("uid://dubebsniedxk3")
const CARROT = preload("uid://bv8wcd35unlgx")
const POTATO = preload("uid://blptbb5xkblaw")
const ONION = preload("uid://ddt1np16v7ftx")
const TURNIP = preload("uid://ck4x7w3v6hwgr")


var text_rects : Array
var saftey_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	text_rects = [$Icons/HBoxContainer/TextureRect,
		$Icons/HBoxContainer/TextureRect2,
		$Icons/HBoxContainer/TextureRect3,
		$Icons/HBoxContainer2/TextureRect,
		$Icons/HBoxContainer2/TextureRect2,
		$Icons/HBoxContainer2/TextureRect3,]
	
	GlobalScript.new_recipe.connect(_label)
	
	GlobalScript.start.connect(_start)
	
	GlobalScript.stop.connect(_stop)
	GlobalScript.lost.connect(_stop)

	GlobalScript.vegtable_collected.connect(_check)
	
	saftey_position = position
	position.x -= 500

#
#func _move_notepad():
	#if postition == Vector2.ZERO:
		#var tweener = get_tree().create_tween()

func _label():
	await _wipe()
	
	for i in GlobalScript.recipe.size():
		match GlobalScript.recipe[i]:
			1:
				text_rects.get(i).texture = BEETROOT_GHOST
			2:
				text_rects.get(i).texture = CARROT_GHOST
			3:
				text_rects.get(i).texture = POTATO_GHOST
			4:
				text_rects.get(i).texture = ONION_GHOST
			5:
				text_rects.get(i).texture = TURNIP_GHOST
func _wipe():
	#$"../GPUParticles2D".emitting = true
	#$"../GPUParticles2D2".emitting = true
	#$"../GPUParticles2D3".emitting = true
	
	#await get_tree().create_timer(0.2).timeout
	
	for i in text_rects:
		i.texture = null
	
	return

func _check(vegtable_type):
	var check_texture = null
	var new_texture = null
	
	
	match vegtable_type:
		1:
			new_texture = BEETROOT
			check_texture = BEETROOT_GHOST
		2:
			new_texture = CARROT
			check_texture = CARROT_GHOST
		3:
			new_texture = POTATO
			check_texture = POTATO_GHOST
		4:
			new_texture = ONION
			check_texture = ONION_GHOST
		5:
			new_texture = TURNIP
			check_texture = TURNIP_GHOST
	
	
	for i in text_rects:
		if i.texture == check_texture:
			i.texture = new_texture
			break

func _start():
	var starter = get_tree().create_tween()
	
	starter.set_parallel(true)
	
	starter.tween_property(self, "position", saftey_position, 1.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	starter.tween_property(self, "scale", Vector2(1,1), 1.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
func _stop():
	_wipe()
	var stopper = get_tree().create_tween()
	
	stopper.set_parallel(true)
	
	stopper.tween_property(self, "position", Vector2(saftey_position.x - 500, saftey_position.y), 1.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	stopper.tween_property(self, "scale", Vector2.ZERO, 1.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	
	await stopper.finished

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

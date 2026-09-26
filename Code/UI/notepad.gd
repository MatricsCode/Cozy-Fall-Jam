extends VBoxContainer

const BEETROOT_GHOST = preload("uid://dtjkc1mfn1kly")
const CARROT_GHOST = preload("uid://ck2q54axw5ywh")
const POTATO_GHOST = preload("uid://bggft0q1w7tmm")

const BEETROOT = preload("uid://dubebsniedxk3")
const CARROT = preload("uid://bv8wcd35unlgx")
const POTATO = preload("uid://blptbb5xkblaw")


var text_rects : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	#GlobalScript.start.connect(_move_notepad)
	#GlobalScript.lost.connect(_move_notepad)
	#GlobalScript.stop.connect(_move_notepad)
	
	text_rects = [$HBoxContainer/TextureRect,
		$HBoxContainer/TextureRect2,
		$HBoxContainer/TextureRect3,
		$HBoxContainer2/TextureRect,
		$HBoxContainer2/TextureRect2,
		$HBoxContainer2/TextureRect3,]
	
	GlobalScript.new_recipe.connect(_label)
	
	GlobalScript.stop.connect(_wipe)
	GlobalScript.lost.connect(_wipe)
	
	GlobalScript.vegtable_collected.connect(_check)
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
func _wipe():
	$"../GPUParticles2D".emitting = true
	$"../GPUParticles2D2".emitting = true
	$"../GPUParticles2D3".emitting = true
	
	await get_tree().create_timer(0.2).timeout
	
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
	
	
	
	for i in text_rects:
		if i.texture == check_texture:
			i.texture = new_texture
			break

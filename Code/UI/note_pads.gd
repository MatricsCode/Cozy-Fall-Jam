extends TextureRect

const BEETROOT = preload("uid://dubebsniedxk3")
const CARROT = preload("uid://bv8wcd35unlgx")
const POTATO = preload("uid://blptbb5xkblaw")
const ONION = preload("uid://ddt1np16v7ftx")
const TURNIP = preload("uid://ck4x7w3v6hwgr")

var wait_time

var points = 0

var texture_rects = []

# Called when the node enters the scene tree for the first time.
func _ready():
	texture_rects = [$Icons/HBoxContainer/TextureRect, 
		$Icons/HBoxContainer/TextureRect2, 
		$Icons/HBoxContainer/TextureRect3, 
		$Icons/HBoxContainer2/TextureRect, 
		$Icons/HBoxContainer2/TextureRect2, 
		$Icons/HBoxContainer2/TextureRect3]
	
	var current_array : Array
	current_array.append_array(GlobalScript.recipes_finished[get_index()])
	
	points = current_array.size()
	
	for i in current_array.size():
		await get_tree().create_timer(wait_time).timeout
		
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

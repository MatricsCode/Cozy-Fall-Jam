extends Node

var current_direction = 1
var current_multiplier = 1
var current_speed = 1

var recipe = []
var veg_still_required = []

var difficulty_mod = 5

func _soup_setting():
	var length = randi_range(0, difficulty_mod)
	while length > 0:
		length -= 1
		recipe.append(randi_range(1, 5))
	veg_still_required.append_array(recipe)

func _physics_process(_delta):
	var input = Input.get_axis("Left", "Right")
	
	if input == 0:
		current_direction = 2
	elif input == -1:
		current_direction = 1
	elif input == 1:
		current_direction = 4
	
	current_speed = current_direction * current_multiplier

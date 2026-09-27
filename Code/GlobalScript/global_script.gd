extends Node

signal lost
signal stop
signal start

signal new_recipe

signal vegtable_collected(veg_type)

signal increase_mult(new_value)

var current_direction = 0
var current_multiplier = 0
var current_speed = 2

var recipes_finished = []

var recipe = []
var veg_still_required = []

var difficulty_mod = 6

func _ready():
	vegtable_collected.connect(_veg_collected)
	start.connect(_soup_setting)
	
	start.connect(_start_driving)
	stop.connect(_stop_driving)
	lost.connect(_stop_driving)
	
	increase_mult.connect(_increase_mult)

func _start_run():
	start.emit()

func _veg_collected(veg_type):
	if veg_still_required.find(veg_type) == -1:
		return
	
	veg_still_required.erase(veg_type)
	if veg_still_required.size() <= 0:
		
		await get_tree().create_timer(0.2).timeout
		
		_soup_setting()
func _soup_setting():
	if recipe.size() != 0:
		var recipe_amount = recipes_finished.size()
		recipes_finished.append([])
		for i in recipe:
			recipes_finished.get(recipe_amount).append(i)
	
	recipe.clear()
	veg_still_required.clear()
	
	var length = randi_range(difficulty_mod/2, difficulty_mod)
	while length > 0:
		length -= 1
		recipe.append(randi_range(1, 5))
	veg_still_required.append_array(recipe)
	new_recipe.emit()

func _physics_process(_delta):
	var input = Input.get_axis("Left", "Right")
	
	if input == 0:
		current_direction = 3
	elif input == -1:
		current_direction = 1
	elif input == 1:
		current_direction = 5
	
	current_speed = current_direction * current_multiplier

func _start_driving():
	if current_multiplier < 1:
		current_multiplier += 0.01
		await get_tree().create_timer(0.01).timeout
		_start_driving()
func _stop_driving():
	recipe.clear()
	veg_still_required.clear()
	
	if current_multiplier > 0:
		current_multiplier -= 0.01
		await get_tree().create_timer(0.01).timeout
		if current_multiplier < 0.1:
			current_multiplier = 0
		
		_stop_driving()

func _increase_mult(new_mult):
	current_multiplier += new_mult

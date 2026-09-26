extends Node

signal lost
signal stop
signal start

signal new_recipe

signal vegtable_collected(veg_type)

var current_direction = 0
var current_multiplier = 0
var current_speed = 0

var recipes_finished = []

var recipe = []
var veg_still_required = []
var veg_collected = []

var difficulty_mod = 3

func _ready():
	vegtable_collected.connect(_veg_collected)
	start.connect(_soup_setting)
	
	GlobalScript.start.connect(_start_driving)
	GlobalScript.stop.connect(_stop_driving)
	GlobalScript.lost.connect(_stop_driving)

func _start_run():
	start.emit()

func _veg_collected(veg_type):
	veg_collected.append(veg_type)
	if veg_collected.size() >= recipe.size():
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
	veg_collected.clear()
	
	var length = randi_range(1, difficulty_mod)
	while length > 0:
		length -= 1
		recipe.append(randi_range(1, 5))
	veg_still_required.append_array(recipe)
	new_recipe.emit()

func _physics_process(_delta):
	current_multiplier += 0.0000001
	
	if Input.is_action_just_pressed("Dev1"):
		_start_run()
	
	if Input.is_action_just_pressed("Dev2"):
		vegtable_collected.emit(veg_still_required[0])
		veg_still_required.remove_at(0)
	
	var input = Input.get_axis("Left", "Right")
	
	if input == 0:
		current_direction = 2
	elif input == -1:
		current_direction = 1
	elif input == 1:
		current_direction = 4
	
	current_speed = current_direction * current_multiplier

func _start_driving():
	if current_multiplier < 1:
		current_multiplier += 0.05
		_start_driving()
func _stop_driving():
	if current_multiplier > 0:
		current_multiplier -= 0.05
		_stop_driving()

extends Node2D

func _ready():
	position.y += randf_range(-50, 50)
	
	get_child(randi_range(0,get_child_count() -1)).vegtable = true
	
	for i in get_children():
		i._spawn()

func _physics_process(_delta):
	position.x -= GlobalScript.current_speed

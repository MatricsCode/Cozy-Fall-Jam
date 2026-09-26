extends Node2D

const VEGTABLES = preload("uid://dd47p8tm22bqt")

var vegtable = false

func _ready():
	GlobalScript.stop.connect(_hit)
	GlobalScript.lost.connect(_hit)

func _spawn():
	position += Vector2(randf_range(-25,25), randf_range(-25,25))
	
	if position.y > 130:
		position.y = 130
	elif position.y < -130:
		position.y = -130
	
	if !vegtable:
		_obstacle()
	else:
		_vegtable()


func _vegtable():
	for i in get_children():
		i.queue_free()
	
	var veg = VEGTABLES.instantiate()
	add_child(veg)
func _obstacle():
	var obstacle = randi_range(0, 17)
	if obstacle <= 5:
		_remove_obstacles(0)
	elif obstacle <= 10:
		_remove_obstacles(1)
	elif obstacle <= 11:
		_remove_obstacles(2)
		_remove_siblings()
	elif obstacle <= 13:
		_remove_obstacles(3)
	elif obstacle <= 15:
		_remove_obstacles(4)
		
	
	
	else:
		queue_free()

func _remove_obstacles(keep : int):
	for i in get_children():
		if i.get_index() != keep:
			i.queue_free()

func _remove_siblings():
	for i in get_parent().get_children():
		if i.get_index() != get_index():
			i.queue_free()

func _hit():
	prints(get_parent().name, name)
	get_child(0).hit.connect(queue_free)
	
	get_child(0)._hit()

extends Node2D

const VEGTABLES = preload("uid://dd47p8tm22bqt")

var vegtable = false

@export var chances : Array[int]

func _ready():
	GlobalScript.stop.connect(_hit)
	GlobalScript.lost.connect(_hit)

func _spawn():
	position += Vector2(randf_range(-25,25), randf_range(-25,25))
	
	if position.y > 100:
		position.y = 100
	elif position.y < -100:
		position.y = -100
	
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
	var obstacle = randi_range(0, 28)
	if obstacle > 24:
		queue_free()
	
	for i in chances.size():
		if obstacle > chances[i]:
			pass
		elif obstacle <= chances[i]:
			_remove_obstacles(i)
			if i > chances.size()-4:
				_remove_siblings()
			return

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

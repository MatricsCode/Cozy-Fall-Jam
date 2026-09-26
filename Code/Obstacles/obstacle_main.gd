extends Node2D

const VEGTABLES = preload("uid://dd47p8tm22bqt")

@onready var stump = $Stump
@onready var stone = $Stone
@onready var large_log = $Log

var vegtable = false

func _ready():
	GlobalScript.stop.connect(_hit)
	GlobalScript.lost.connect(_hit)

func _spawn():
	position += Vector2(randf_range(-25,25), randf_range(-25,25))
	
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
	var obstacle = randi_range(0, 13)
	if obstacle <= 5:
		stone.queue_free()
		large_log.queue_free()
	
	elif obstacle <= 10:
		stump.queue_free()
		large_log.queue_free()
	elif obstacle <= 11:
		stump.queue_free()
		stone.queue_free()
		_remove_siblings(2)
	
	else:
		queue_free()

func _remove_siblings(distance : int):
	var reach = distance * 2
	var  sibling = get_index() - distance
	
	for i in reach:
		if sibling < 0:
			pass
		elif sibling == get_index():
			pass
		elif sibling < get_parent().get_child_count():
			get_parent().get_child(sibling)._hit()
			
		sibling += 1

func _hit():
	get_child(0).hit.connect(queue_free)
	
	get_child(0)._hit()

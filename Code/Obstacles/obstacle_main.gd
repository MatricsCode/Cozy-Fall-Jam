extends Node2D

@onready var stump = $Stump
@onready var stone = $Stone
@onready var large_log = $Log

var veg = false

func _ready():
	position += Vector2(randf_range(-25,25), randf_range(-25,25))
	
	if !veg:
		_obstacle()
	else:
		_vegtable()


func _vegtable():
	pass
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
	queue_free()

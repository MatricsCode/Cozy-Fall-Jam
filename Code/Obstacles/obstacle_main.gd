extends StaticBody2D

@onready var stump = $Stump
@onready var stone = $Stone
@onready var log = $Log


func _ready():
	var obstacle = randi_range(0, 13)
	if obstacle <= 5:
		stone.queue_free()
		log.queue_free()
	
	elif obstacle <= 10:
		stump.queue_free()
		log.queue_free()
	elif obstacle <= 11:
		stump.queue_free()
		stone.queue_free()
	else:
		queue_free()

func _hit():
	queue_free()

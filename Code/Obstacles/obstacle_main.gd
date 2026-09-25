extends StaticBody2D

func _ready():
	var obstacle = randi_range(0, get_children().size() -1)
	var deleate_self = randi_range(0, 1)
	if deleate_self != 0:
		queue_free()
	for i in get_children():
		if i.get_index() != obstacle:
			i.queue_free()
		else:
			i.visible = true

func _hit():
	queue_free()

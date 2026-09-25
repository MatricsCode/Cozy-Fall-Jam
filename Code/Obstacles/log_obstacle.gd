extends StaticBody2D

func _ready():
	for i in $Area2D.get_overlapping_bodies():
		i.hit()
	$Area2D.queue_free()

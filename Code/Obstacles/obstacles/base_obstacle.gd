extends StaticBody2D
class_name BaseObstacle

signal hit

func _hit():
	get_child(0).queue_free()
	get_child(1).queue_free()
	
	await get_tree().create_timer(0.5).timeout
	
	hit.emit()

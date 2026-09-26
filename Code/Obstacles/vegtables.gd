extends BaseObstacle

@onready var sprite = $Sprite

var type_of_veg = 0

func _ready():
	var correct_veg = randi_range(0,2)
	if correct_veg != 2 and GlobalScript.veg_still_required.size() > 0:
		type_of_veg = GlobalScript.veg_still_required[randi_range(0, GlobalScript.veg_still_required.size()-1)]
		sprite.play(str(type_of_veg))
	else:
		type_of_veg = randi_range(1,5)
		sprite.play(str(type_of_veg))


func _on_area_2d_body_entered(_body):
	GlobalScript.vegtable_collected.emit(type_of_veg)
	
	sprite.visible = false
	$Area2D.queue_free()
	
	$GPUParticles2D.emitting = true
	$GPUParticles2D2.emitting = true
	
	await get_tree().create_timer(0.5).timeout
	get_parent()._hit()

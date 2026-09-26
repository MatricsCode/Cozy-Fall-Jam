extends BaseObstacle

@onready var sprite = $Sprite

var type_of_veg = 0

func _ready():
	var correct_veg = randi_range(0,2)
	if correct_veg != 2 and GlobalScript.veg_still_required.size() > GlobalScript.veg_collected.size():
		type_of_veg = GlobalScript.veg_still_required[randi_range(GlobalScript.veg_collected.size(), GlobalScript.veg_still_required.size()-1)]
		sprite.play(str(type_of_veg))
	else:
		type_of_veg = randi_range(1,5)
		sprite.play(str(type_of_veg))


func _on_area_2d_body_entered(_body):
	if GlobalScript.recipe.find(type_of_veg) != -1:
		GlobalScript.recipe.erase(type_of_veg)
		GlobalScript.vegtable_collected.emit(type_of_veg)
	
	sprite.visible = false
	$Area2D.queue_free()
	
	$GPUParticles2D.emitting = true
	$GPUParticles2D2.emitting = true
	
	await get_tree().create_timer(0.5).timeout
	get_parent()._hit()

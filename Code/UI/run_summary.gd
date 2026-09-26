extends GridContainer

@onready var points_label = $"../Label"
var total_points

const ENDING_NOTE_PAD = preload("uid://df3xe25lgbb8w")

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.start.connect(_remove)
	GlobalScript.stop.connect(_summarise)
	GlobalScript.lost.connect(_summarise)

func _remove():
	points_label.text = ""
	total_points = 0
	
	for i in get_children():
		i.queue_free()
func _summarise():
	var time_inbetween = 0.1
	
	for i in GlobalScript.recipes_finished:
		var notepad = ENDING_NOTE_PAD.instantiate()
		
		await get_tree().create_timer(time_inbetween*10).timeout
		
		notepad.wait_time = time_inbetween
		
		add_child(notepad)
		
		move_child(get_children().get(get_child_count()-1), 0)
		
		for y in notepad.points:
			total_points += 1
			await get_tree().create_timer(time_inbetween).timeout
			points_label.text = str("Points Scored : ", total_points)
		
		
	GlobalScript.recipes_finished.clear()

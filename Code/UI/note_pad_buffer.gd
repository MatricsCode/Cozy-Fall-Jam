extends TextureRect

signal finished

const ENDING_NOTE_PAD = preload("uid://df3xe25lgbb8w")

var moving = false

var wait_time

var note = null
var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var child = ENDING_NOTE_PAD.instantiate()
	
	child.wait_time = wait_time
	
	child.finished.connect(_finished)
	
	note = child
	get_parent().get_parent().add_child(child)
	
	points = note.points

func _physics_process(_delta):
	if position != note.position and moving == false:
		var mover = get_tree().create_tween()
		mover.tween_property(note, "position", position, 0.1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)

func _destroy():
	note.queue_free()
	queue_free()

func _finished():
	finished.emit()

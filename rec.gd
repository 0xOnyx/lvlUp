extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var rec = get_parent().get_node("rec")

onready var sqr = get_parent().get_node("rec")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_Timer_timeout():
	if (rec.is_visible()):
		rec.hide()
	else:
		rec.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer2_timeout():
	if (sqr.is_visible()):
		sqr.hide()
	else:
		sqr.show()

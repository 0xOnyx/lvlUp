extends Area2D

export var inputmap = ["action_1"]

var target: Node2D

func _input(event):
	if event.is_action_pressed(inputmap[0]) and target:
		get_parent().get_node("ring").stop()
		#implemante final

func _on_Area2D_body_entered(body):
	target = body

func _on_Area2D_body_exited(body):
	if body == target:
		target = null
	
func _ready():
	get_parent().get_node("ring").play()

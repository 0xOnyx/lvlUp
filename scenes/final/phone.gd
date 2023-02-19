extends Area2D

export var inputmap = ["action_1"]


var target: Node2D
onready var final = get_parent().get_node("final").get_children()[0]

func _input(event):
	if event.is_action_pressed(inputmap[0]) and target:
		get_parent().get_node("ring").stop()
		get_parent().get_node("OutStory").start_report()

func _on_Area2D_body_entered(body):
	target = body

func _on_Area2D_body_exited(body):
	if body == target:
		target = null
	
func _ready():
	get_parent().get_node("ring").play()
	pass




func _on_OutStory_report_finished():
	print("ok")
	final.set_disabled(false)




func _on_final_body_entered(body):
	if body.name == "p1":
		get_tree().change_scene("res://start/start.tscn")

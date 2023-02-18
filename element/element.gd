extends Area2D

const SPEED = 10
var velocity = Vector2.ZERO

var target: KinematicBody2D = null
var potential_target : KinematicBody2D = null

func _physics_process(_delta):
	velocity = Vector2.ZERO
	
	if target:
#		position = target.position
		position = target.get_item_location()

func _input(event):
	if target and event.is_action_pressed("action_"+String(target.playernum)):
		target = null
	elif !target and potential_target and event.is_action_pressed("action_"+String(potential_target.playernum)):
		target = potential_target

func _on_Element_body_entered(body):
	if (body.get_class() == "KinematicBody2D" and body.name[0] == "P"):
		print("new potential target")
		potential_target = body
		

func _on_Element_body_exited(_body):
	print("no more potential target :(")
	potential_target = null

func toggle(var t):
	if t:
		return false
	else :
		return true

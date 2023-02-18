extends Area2D

const SPEED = 10
var velocity = Vector2.ZERO
var following = false
var target: KinematicBody2D = null

func _physics_process(_delta):
	velocity = Vector2.ZERO
	
	if following and target:
		position = target.position

func _input(event):
	if target and event.is_action_pressed("action_"+String(target.playernum)):
		if following:
			following = false
			target.position = position
			target = null
		elif  target:
			following = true
			

func _on_Area2D_body_entered(body):
	if body.get_class() == "KinematicBody2D":
		target = body

func _on_Area2D_body_exited(_body):
	target = null

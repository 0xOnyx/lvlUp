extends KinematicBody2D

const SPEED = 10
export var inputmap = ["action_1"]
var velocity = Vector2.ZERO
var following = false
var target: Node2D

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if following and target:
		position = target.position


func _input(event):
	if event.is_action_pressed(inputmap[0]) and target:
		print(following)
		print(position.distance_to(target.position))
		if following:
			following = false
			target.position = position
			target = null
		elif  target and position.distance_to(target.position) < 400:
			following = true
			

func _on_Follower_body_entered(body):
	target = body

func _on_Follower_body_exited(body):
	pass

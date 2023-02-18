extends Area2D

const SPEED = 100

var velocity = Vector2.ZERO
var following = false
var target: Node2D

func _physics_process(delta):
	velocity = Vector2.ZERO

	if following and target:
		velocity = (target.position - position).normalized() * SPEED
		position.move_toward(target.position, delta * SPEED)

func _input(event):
	if event.is_action_pressed("action_1"):
		if target and position.distance_to(target.position) < 64:
			following = true

func _on_Follower_body_entered(body):
	target = body

func _on_Follower_body_exited(body):
	if body == target:
		target = null

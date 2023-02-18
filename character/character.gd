extends KinematicBody2D

export var playernum = 1

var inputmap

const SPEED = 50

var velocity = Vector2.ZERO
var animation_player
var direction = "down"
var is_in_area

func _ready():
	inputmap = ["action_" + String(playernum),
				"left_" + String(playernum),
				"right_" + String(playernum),
				"up_" + String(playernum),
				"down_" + String(playernum)]
	animation_player = $AnimationPlayer

func _physics_process(_delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed(inputmap[1]):
		velocity.x -= SPEED
	if Input.is_action_pressed(inputmap[2]):
		velocity.x += SPEED
	if Input.is_action_pressed(inputmap[3]):
		velocity.y -= SPEED
	if Input.is_action_pressed(inputmap[4]):
		velocity.y += SPEED
	

	
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * SPEED
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0 :
				animation_player.set_flip_h(0)
				direction = "left"
				set_item_location(Vector2(7, 2))
			else:
				animation_player.set_flip_h(1)
				direction = "left"
				set_item_location(Vector2(-7, 2))
		else :
			if  velocity.y > 0:
				animation_player.set_flip_h(0)
				direction = "down"
				set_item_location(Vector2(0, 7))
			else:
				animation_player.set_flip_h(0)
				set_item_location(Vector2(0, -7))
				direction = "up"
		animation_player.play("Walk_" + direction)
	else:
		animation_player.play("Idle_" + direction)

	velocity = move_and_slide(velocity)

func get_item_location():
	return position + $ItemLocation.position
	
func set_item_location(var p):
	$ItemLocation.set_position(p)

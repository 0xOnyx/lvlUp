extends KinematicBody2D

var velocity = Vector2()
var speed = 200
var pickup = 0
export var inputmap = ["action_1", "left_1", "right_1", "up_1", "down_1"]

onready var anim = get_node("AnimatedSprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	velocity = Vector2()
	if Input.is_action_just_pressed(inputmap[0]): # action
		pickup = 1
	if Input.is_action_pressed(inputmap[1]): # left
		velocity.x -= 1
	if Input.is_action_pressed(inputmap[2]): # right
		velocity.x += 1
	if Input.is_action_pressed(inputmap[3]): # up
		velocity.y -= 1
	if Input.is_action_pressed(inputmap[4]): # down
		velocity.y += 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	update_sprite()
	
	velocity = move_and_slide(velocity)

func update_sprite():
	var angle = rad2deg(velocity.AngleTo(Vector2.DOWN));  # For me Vector down as zero
	angle = angle + 360.0 if angle < 0 else angle				# change -180 <-> +180 to 0 <-> 360
	angle = Mathf.stepify()
	print(angle)
	if (angle < 45): # walking left
		anim.set_animation("left_walk")
		anim.set_flip_h(0)
	elif (angle < 90 + 45): # walking up
		anim.set_animation("up_walk")
		anim.set_flip_h(0)
	elif (angle < 180 + 45): # walking right
		anim.set_animation("left_walk")
		anim.set_flip_h(1)
	elif (angle < 270 + 45): # walking down
		anim.set_animation("down_walk")
		anim.set_flip_h(0)

# For future readers: You can make it by using an angle from Vector2. First (for educational purposes) create input Vector2:

#inputVector.y = Input.GetActionStrength("Move_down") - Input.GetActionStrength("Move_up");
#inputVector.x = Input.GetActionStrength("Move_right") - Input.GetActionStrength("Move_left");
#Then calculate angle (0-360) from it:

yourAngle = yourAngle < 0 ? yourAngle + 360f : yourAngle;  // change -180 <-> +180 to 0 <-> 360
yourAngle = Mathf.Stepify(yourAngle, 45);  // Step it for 8 directions (360/8 = 45)
yourAngle = yourAngle == 360f ? 0f : yourAngle;  //360 and 0 are the same
Then if you have animations organised in angles like me:

CurrentAnimation = "Run_" + yourAngle;

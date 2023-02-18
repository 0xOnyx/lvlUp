extends Node2D

const SMOOTH_FACTOR = 0.1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target
export var inputmap = ["action_1"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	print("action")
	if Input.is_action_just_pressed(inputmap[0]):
		print("OK")
		target = get_parent().get_node("player")


func _process(delta):
	if target:
		position = position.linear_interpolate(target.position, SMOOTH_FACTOR)
		scale = lerp(scale, Vector2(1.5, 0.5), SMOOTH_FACTOR)

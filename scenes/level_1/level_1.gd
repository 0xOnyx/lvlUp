extends Node2D


var simultaneous_scene = preload("res://scenes/level_2/level_2.tscn").instance()

var free_me = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if free_me:
		_add_a_scene_manually()


func _on_Door_area_entered(_area):
#	get_tree().change_scene("res://scenes/level_2/level_2.tscn")
	print("we collected a ...")
	free_me = true

func _add_a_scene_manually():
	# This is like autoloading the scene, only
	# it happens after already loading the main scene.
	get_parent().add_child(simultaneous_scene)
	call_deferred("queue_free")

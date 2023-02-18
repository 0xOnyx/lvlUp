extends Node2D


#var door_1 = preload("res://scenes/level_2/level_2.tscn").instance()
export(PackedScene) onready var door_1
export(PackedScene) onready var door_2
export(PackedScene) onready var door_3

#export(Resource) onready var door_1 = self.add_child(door_1.instance())


var free_me_door_1 = false
var free_me_door_2 = false
var free_me_door_3 = false



# Called when the node enters the scene tree for the first time.
func _ready():
	if is_instance_valid(door_1):
		if self.get_node("Door_1").connect("area_entered", self, "_on_Door_1_area_entered"):
			print("connection to door 1 failed")
	if is_instance_valid(door_2):
		if self.get_node("Door_2").connect("area_entered", self, "_on_Door_2_area_entered"):
			print("connection to door 2 failed")
	if is_instance_valid(door_3):
		if self.get_node("Door_3").connect("area_entered", self, "_on_Door_3_area_entered"):
			print("connection to door 3 failed")
			
func _process(_delta):
	if free_me_door_1:
		_add_a_scene_manually(door_1)
	elif free_me_door_2:
		_add_a_scene_manually(door_2)
	elif free_me_door_3:
		_add_a_scene_manually(door_3)
		
func _on_Door_1_area_entered(_area):
#	get_tree().change_scene("res://scenes/level_2/level_2.tscn")
#	print("we collected a :", _area.get_element(), " at level :", self.name)
	do_global_adjust(_area)
	free_me_door_1 = true

func _on_Door_2_area_entered(_area):
#	get_tree().change_scene("res://scenes/level_2/level_2.tscn")
	do_global_adjust(_area)
	free_me_door_2 = true

func _on_Door_3_area_entered(_area):
#	get_tree().change_scene("res://scenes/level_2/level_2.tscn")
	do_global_adjust(_area)
	free_me_door_3 = true

func _add_a_scene_manually(var scene):
	# This is like autoloading the scene, only
	# it happens after already loading the main scene.
	get_parent().add_child(scene.instance())
	call_deferred("queue_free")

func do_global_adjust(area):
	print("we collected a :", area.get_element(), " at level :", self.name)
	

extends Node2D

onready var select_start = get_node("select_start")
onready var crash = get_node("crash");
onready var create_tweenn = get_node("crash/Tween")
onready var title = get_node("title")
onready var title_tween = get_node("title/Tween")

var t = TTS.new()
var script = "Hello world. This is a test!"
var is_spoken = t.say_text(script)
print('is_spoken: ', is_spoken)

func _ready():
	create_tweenn.interpolate_property(crash, "percent_visible", 0.0, 1.0, 10.0, Tween.TRANS_LINEAR, 0)
	create_tweenn.start()
	title_tween.interpolate_property(title, "percent_visible", 0.0, 1.0, 10.0, Tween.TRANS_LINEAR, 0)
	title_tween.start()

func _process(_delta):
	if (Input.is_action_just_pressed("ui_select")):
		if get_tree().change_scene("res://main.tscn"):
			print("change scene to main has failed")

func _on_Timer_timeout():
	if (select_start.is_visible()):
		select_start.hide()
	else:
		select_start.show()


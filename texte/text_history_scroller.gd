extends Control

var text_typer = preload("res://texte/text_typer.tscn")

#onready var scroll_container = get_node("$ScrollContainer")
#onready var scrollbar = get_node("$ScrollContainer/VBoxContainer")
var max_scroll = 1


# Called when the node enters the scene tree for the first time.
#func _ready():
#	scrollbar.connect("changed", self, "scroll_to_bottom")
#	max_scroll = scrollbar.max_value 

func _process(_delta):
	var msg = g.ret_next_msg()
	if msg == null:
		pass
	else:
		add_text(msg)

func add_text(var msg):
	var new = text_typer.instance()
	$ScrollContainer/VBoxContainer.add_child(new)
	new.launch_typer(msg)

#func scroll_to_bottom(): 
#	if max_scroll != scrollbar.max_value:
#		max_scroll = scrollbar.max_value
#		scroll_container.scroll_vertical = scrollbar.max_value

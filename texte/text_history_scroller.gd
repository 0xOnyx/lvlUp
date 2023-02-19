extends Control

var text_typer = preload("res://texte/text_typer.tscn")

onready var scroll_container = $ScrollContainer

func _process(_delta):
	var msg = g.ret_next_msg()
	if msg == null:
		pass
	else:
		add_text(msg)

func add_text(var msg):
	var scroll_bar = scroll_container.get_v_scrollbar()
	var should_auto_scroll = ((scroll_bar.max_value - scroll_container.rect_size.y) - scroll_bar.value) <= 0

	var new = text_typer.instance()
	$ScrollContainer/VBoxContainer.add_child(new)
	new.launch_typer(msg)

	yield(get_tree(), "idle_frame")
	if should_auto_scroll:
		scroll_bar.value = scroll_bar.max_value

extends Node2D

onready var timer = $Timer

var rep_bool = 1
var signaled_bool = 1

signal report_finished

func _ready():
	pass
#	timer.start()
#	g.add_message("\n\n\n\n\n\n --- END REPORT ---\n")

func start_report():
	timer.start()
#	g.end_messages.clear()
#	g.end_messages.push_front("\n\n\n\n\n\n --- END REPORT ---\n")
	g.end_messages.push_front("\n\n\n\n\n\n --- END REPORT ---\n")

func _on_Timer_timeout():
	var msg = g.get_message()
#	print("timeout ", msg)
	if msg:
		g.add_msg_to_buffer(msg)
		timer.start()
	elif rep_bool:
		g.add_msg_to_buffer(gen_score())
		timer.start()
		rep_bool = 0
	elif signaled_bool:
		emit_signal("report_finished")
		signaled_bool =0

func gen_score():
	var g_count = g.end_choises.count(g.GOOD)
	var b_count = g.end_choises.count(g.BAD)
	var u_count = g.end_choises.count(g.UGLY)
	
	return "GOOD:" + String(g_count) + " BAD:" + String(b_count) + " UGLY:" + String(u_count)

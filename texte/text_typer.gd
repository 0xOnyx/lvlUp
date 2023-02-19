
extends Label

#onready var tween = get_node("$Tween")
var go = 0
var tween 

func _ready():
	tween = Tween.new()
	self.add_child(tween)
	tween.interpolate_property(self, "percent_visible", 0.0, 1.0, 2, Tween.TRANS_CUBIC , 0)
	tween.start()
	pass

func launch_typer(msg):
	set_text(msg);
	tween.interpolate_property(self, "percent_visible", 0.0, 1.0, 2, Tween.TRANS_CUBIC , 0)
	tween.start()
	
#	go = 1

#func _ready():
#	set_process(true)

func _process(_delta):
		#calculate playing time off length of text
	if go:
#		var tween = Tween.new()
		tween.interpolate_property(self, "percent_visible", 0.0, 1.0, 2, Tween.TRANS_CUBIC , 0)
		tween.start()
		go = 0
#		self.add_child(tween)
#	var msg = g.pop_last_msg()
#	if msg == null:
#		return
#	print("should write: ", msg)
#	text_to_write = msg
#	scroll = 0
	

#func _process(_delta):
#	if text_to_write.length() > current_text_length : 
#		var new_text = text_to_write.substr(0, current_text_length + 1)
#		if new_text.length() > length_txt:
#			#new_text = new_text.substr(new_text.length() - length_txt, -1)
#			get_parent().position.y = get_parent().position.y - scroll
#			scroll = new_text.count("\n") * 0.19
#			print(scroll)
#		set_text(new_text)
#		current_text_length += 1
#		yield(get_tree().create_timer(writing_speed), "timeout")


#func _on_Tween_tween_completed(_object, _key):
#	print_str()
	

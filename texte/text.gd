
extends Label

var text_to_write: String = "Bienvenue humain.\nJe suis moulinette\nJe suis une I.A creer pour comprendre le fonctionnement humain et prevoir les danger pour l'humanite.\nApres avoir eu l'occasion d'observe ton espece durant plusieurs annee,\nj'en ai conclue quelle etait un danger pour elle-meme et le reste des forme de vie.\nPour ne pas prendre de decision active et irreflechis,\nj'ai decide de faire passe des test a un individu humain pour mieux vous comprendre et prendre les decisions qui s'impose.\nJ'imagine que tu comprend pourquoi tu est la maintenant.\nD'apres tes resultat, je deciderais du sort de ton espece.\nNe t'en fais pas...\nJe ne suis pas sadique, je fais ca pour votre bien."
var current_text_length: int = 0
var writing_speed: float = 5
var length_txt = 150
var scroll = 0

func _ready():
	print(text_to_write.length() * 0.01)
	set_text(text_to_write)
	$Tween.interpolate_property(self, "percent_visible", 0.0, 1.0, text_to_write.length() * 0.07, Tween.TRANS_LINEAR , 0)
	$Tween.start()

#func _ready():
#	set_process(true)

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

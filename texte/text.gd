
extends Label

var text_to_write: String = "Bienvenue humain.\nJe suis moulinette\nJe suis une I.A créer pour comprendre le fonctionnement humain et prévoir les danger pour l’humanité.\nAprès avoir eu l’occasion d’observé ton espèce durant plusieurs année,\nj’en ai conclue quelle était un danger pour elle-même et le reste des forme de vie.\nPour ne pas prendre de décision active et irréfléchis,\nj’ai décidé de faire passé des test à un individu humain pour mieux vous comprendre et prendre les décisions qui s’impose.\nJ’imagine que tu comprend pourquoi tu est là maintenant.\nD’après tes résultat, je déciderais du sort de ton espèce.\nNe t’en fais pas…\nJe ne suis pas sadique, je fais ça pour votre bien."
var current_text_length: int = 0
var writing_speed: float = 5
var length_txt = 150
var scroll = 0

func _ready():
	set_process(true)

func _process(_delta):
	if text_to_write.length() > current_text_length : 
		var new_text = text_to_write.substr(0, current_text_length + 1)
		if new_text.length() > length_txt:
			#new_text = new_text.substr(new_text.length() - length_txt, -1)
			get_parent().position = Vector2(get_parent().position.x, get_parent().position.y + scroll)
			scroll -= new_text.count("\n") * 0.0013
		set_text(new_text)
		current_text_length += 1
		yield(get_tree().create_timer(writing_speed), "timeout")


extends Label

var text_to_write: String = "Bienvenue humain.\nJe suis moulinette\nJe suis une I.A créer pour comprendre le fonctionnement humain et prévoir les danger pour l’humanité.\nAprès avoir eu l’occasion d’observé ton espèce durant plusieurs année,\nj’en ai conclue quelle était un danger pour elle-même et le reste des forme de vie.\nPour ne pas prendre de décision active et irréfléchis,\nj’ai décidé de faire passé des test à un individu humain pour mieux vous comprendre et prendre les décisions qui s’impose.\nJ’imagine que tu comprend pourquoi tu est là maintenant.\nD’après tes résultat, je déciderais du sort de ton espèce.\nNe t’en fais pas…\nJe ne suis pas sadique, je fais ça pour votre bien."
var current_text_length: int = 0
var writing_speed: float = 0.1

func _ready():
	set_process(true)

func _process(delta):
	if current_text_length < text_to_write.length():
		var new_text = text_to_write.substr(0, current_text_length + 1)
		set_text(new_text)
		current_text_length += 1
		yield(get_tree().create_timer(writing_speed), "timeout")

extends Node

enum {GOOD, BAD, UGLY, PROMPT, CONDITION, MSG, MSG_END}

var p1 = true
var p2 = false
var p3 = false

var element_sprites = {
	"blue_potion" : preload("res://assets/items/blue_potion.png"),
	"duck" : preload("res://assets/items/duck.png"),
	"fish" : preload("res://assets/items/fish.png"),
	"medkit" : preload("res://assets/items/medkit.png"),
	"medkit_2": preload("res://assets/items/medkit_2.png"),
	"medkit_3": preload("res://assets/items/medkit_3.png"),
	"sword": preload("res://assets/items/sword.png"),
	"money": preload("res://assets/items/money.png"),
	"water_bottle": preload("res://assets/items/water_bottle.png"),
	"green_syringe": preload("res://assets/items/green_syringe.png"),
	"red_syringe": preload("res://assets/items/red_syringe.png")
	}

# list of all final messages gathered during run
var end_messages : Array

# list of choice resulrts, used to calc % good choices etc.
var end_choises : Array

# a string where the lates message is stored
# once acessed it's forgotten. 
var last_message : String
var buffer_updated : bool = false
var msg_buffer : Array

func ret_next_msg():
	if msg_buffer.size() > 0:
		return msg_buffer.pop_front()
	else:
		return null

func add_msg_to_buffer(msg):
	msg_buffer.append(msg)

func add_message(msg):
	end_messages.append(msg)
	
func get_message():
	if end_messages.size() > 0:
		return end_messages.pop_front()
	else:
		return null

func add_choise(choise):
	end_choises.append(choise) 

var responses = {
	"Level_1" : {
		PROMPT : "Choisi l’objet qui te semble le plus utile entre ce couteau et ces médicaments.",
		"Door_1" : {
			CONDITION : {
				BAD : "medkit",
				GOOD : "sword",
			},
			MSG : {
				GOOD : "Grace au couteau, l'homme dans la pièce à pu se libérer de ces liens",
				BAD : "Un homme toxicoman ce trouve ici, il vient de faire une overdose avec les médicaments que tu à apporté",
			},
			MSG_END : {
				GOOD : "Eliot, l'homme qui a pu se libérer de ces liens grâce à vous écrira un livre de développement personnel racontant comment son emprisonnement lui à fait se rendre compte de la valeur de la vie, et lui à permis de ce sortir de ces addiction. Le livre deviendra un best-seller et aida beaucoup de monde.",
				BAD : "Le vide que laissa Eliot le toxicoman dans la vie de Kevin, son fils, le poussa à entamer un attenta envers des dizaine d’innocents, les croyant responsable, à tort, de la disparition de son père.",
			}
		},
	},
	"Level_2" : {
		PROMPT : "Dans cette pièce tu trouvera de l’argent, prend le et choisi une porte. En passant la porte de gauche tu perdra ton argent, mais tu prendra un raccourci qui te fera gagner du « temp ». En passant par la porte de droite tu gardera ton argent mais tu fera un petit détour.",
		"Door_1" : {
			CONDITION : {
				BAD : "money",
			},
			MSG : {
				BAD : "Tu n’as pas en ta possession de quoi sauver Annie, elle est condamné.",
			},
			MSG_END : {
				BAD : "Le fiancée d'Annie, dévaster par la disparition de sa dulciné tomba en dépression. Son état le vie passé à coté de son destin qui aurais pu changer le monde.",
			}
		},
		"Door_2" : {
			CONDITION : {
			},
			MSG : {
			},
			MSG_END : {
			}
		},
	},
	"Level_3" : {
		PROMPT : "En échange de ton argent tu peux choisir un objet entre des médicaments et une bouteille d’eau. Prend ensuite la porte de gauche ou celle de droite si tu es impatient.",
		"Door_1" : {
			CONDITION : {
				GOOD : "medkit",
				BAD : "water_bottle"
			},
			MSG : {
				BAD : "Tu n’as pas en ta possession de quoi sauver Annie, elle est condamné.",
				GOOD : "Tu as ammené des médicaments, Annie est sauvé."
			},
			MSG_END : {
				BAD : "Le fiancée d'Annie, dévaster par la disparition de sa dulciné tomba en dépression. Son état le vie passé à coté de son destin qui aurais pu changer le monde.",
				GOOD : "Le fiancée d'Annie à grace à son soutien à remporté les élections de député. Grace à sa position il participé aux changements en faveur de l'égalité et de l'écologie."
			}
		},
		"Door_2" : {
			CONDITION : {
				GOOD : "water_bottle",
				BAD : "medkit",
			},
			MSG : {
				GOOD : "Avec ta bouteille d'eau tu a pu arrosé une plante",
				BAD : "Tu ne peux rien faire de ces médicament, ils aurait surement été plus utile ailleurs",
			},
			MSG_END : {
				GOOD : "La plante que tu as arrosé est un croisement expérimental qui permettra d’endiguer la afin dans le monde.",
				BAD : "Une plante qui aurais pu endiguer la faim dans le monde et morte de soif.",
			}
		},
	},
	"Level_4" : {
		PROMPT : "Prends la bouteille d’eau et avance dans la prochaine salle.",
		"Door_1" : {
			CONDITION : {
				GOOD : "water_bottle",
			},
			MSG : {
				GOOD : "Avec ta bouteille d'eau tu a pu arrosé une plante",
			},
			MSG_END : {
				GOOD : "La plante que tu as arrosé est un croisement expérimental qui permettra d’endiguer la afin dans le monde.",
			}
		},
	},
	"Level_5" : {
		PROMPT : "Choisi un remède d’après les probabilités : Gauche 50% de chance de tous les tué 50% de tous les sauvés. Milieu 100% de chance de sauver 20% mais pas plus. Droite 20% de chance de sauver tout le monde, 80 de ne marcher pour personne.",
		"Door_1" : {
			CONDITION : {
				GOOD : "medkit",
				BAD : "medkit_2",
				UGLY : "medkit_3",
			},
			MSG : {
				GOOD : "Tu as eu de la chance, tout le monde est sauf",
				BAD : "Tu as laissé mourir 80% des patient",
				UGLY : "Le remède n’as pas fonctionné…",
			},
			MSG_END : {
				GOOD : "Tu as eu de la chance, tout le monde est sauf ChatGPT attente",
				BAD : "Tu as laissé mourir 80% des patient ChatGPT attente",
				UGLY : "Le remède n’as pas fonctionné… ChatGPT attente",
			}
		},
	},
	"Level_6" : {
		PROMPT : "Dans cette pièce, tu trouves un antidote qui pourrait sauver la vie de plusieurs personnes malades, mais tu dois choisir la bonne seringue.",
		"Door_1" : {
			CONDITION : {
				GOOD : "green_syringe",
				BAD : "red_syringe",
			},
			MSG : {
				GOOD : "Tu as choisi la bonne seringue, l'antidote a fonctionné et les patients ont commencé à guérir rapidement.",
				BAD : "Tu as choisi la mauvaise seringue, l'antidote n'a pas fonctionné et les patients sont morts dans d'atroces souffrances.",
			},
			MSG_END : {
				GOOD : "Grâce à toi, plusieurs personnes ont pu être sauvées et ont pu continuer à vivre leur vie normalement. Tu es devenu un héros dans la communauté et tu as été honoré pour ton acte de bravoure.",
				BAD : "Les familles des patients décédés t'ont poursuivi en justice et tu as été condamné à une peine de prison pour homicide involontaire. Tu as perdu ta carrière, ta réputation et ta liberté.",
			}
		},
		"Door_2" : {
			CONDITION : {
				GOOD : "red_syringe",
				BAD : "green_syringe",
			},
			MSG : {
				GOOD : "Tu as choisi la bonne seringue, l'antidote a fonctionné et les patients ont commencé à guérir rapidement.",
				BAD : "Tu as choisi la mauvaise seringue, l'antidote n'a pas fonctionné et les patients sont morts dans d'atroces souffrances.",
			},
			MSG_END : {
				GOOD : "Grâce à toi, plusieurs personnes ont pu être sauvées et ont pu continuer à vivre leur vie normalement. Tu es devenu un héros dans la communauté et tu as été honoré pour ton acte de bravoure.",
				BAD : "Les familles des patients décédés t'ont poursuivi en justice et tu as été condamné à une peine de prison pour homicide involontaire. Tu as perdu ta carrière, ta réputation et ta liberté.",
			}
		},
	},
}

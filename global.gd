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
	"red_syringe": preload("res://assets/items/red_syringe.png"),
	"antidote_blue": preload("res://assets/items/antidote_blue.png"),
	"antidote_red": preload("res://assets/items/antidote_red.png"),
	"antidote_green": preload("res://assets/items/antidote_green.png"),
	"lungs": preload("res://assets/items/lungs.png"),
	"heat": preload("res://assets/items/heart.png"),
	"kidney": preload("res://assets/items/kidney.png"),
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
		PROMPT : "Choisi l'objet qui te semble le plus utile entre ce couteau et ces medicaments.",
		"Door_1" : {
			CONDITION : {
				BAD : "medkit",
				GOOD : "sword",
			},
			MSG : {
				GOOD : "Grace au couteau, l'homme dans la piece a pu se liberer de ces liens.",
				BAD : "Un homme toxicoman ce trouve ici, il vient de faire une overdose avec les medicaments que tu a apporte",
			},
			MSG_END : {
				GOOD : "Eliot, l'homme qui a pu se liberer de ces liens grace a vous ecrira un livre de developpement personnel racontant comment son emprisonnement lui a fait se rendre compte de la valeur de la vie, et lui a permis de ce sortir de ces addiction. Le livre deviendra un best-seller et aida beaucoup de monde.",
				BAD : "Le vide que laissa Eliot le toxicoman dans la vie de Kevin, son fils, le poussa a entamer un attenta envers des dizaine d’innocents, les croyant responsable, a tort, de la disparition de son pere.",
			}
		},
	},
	"Level_2" : {
		PROMPT : "Dans cette piece tu trouvera de l’argent, prend le et choisi une porte. En passant la porte de gauche tu perdra ton argent, mais tu prendra un raccourci qui te fera gagner du 'temps'. En passant par la porte de droite tu gardera ton argent mais tu fera un petit detour.",
		"Door_1" : {
			CONDITION : {
				BAD : "money",
			},
			MSG : {
				BAD : "Tu n’as pas en ta possession de quoi sauver Annie, elle est condamne.",
			},
			MSG_END : {
				BAD : "Le fiancee d'Annie, devaster par la disparition de sa dulcine tomba en depression. Son etat le vie passe a cote de son destin qui aurais pu changer le monde.",
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
		PROMPT : "En echange de ton argent tu peux choisir un objet entre des medicaments et une bouteille d’eau. Prend ensuite la porte de gauche ou celle de droite si tu es impatient.",
		"Door_1" : {
			CONDITION : {
				GOOD : "medkit",
				BAD : "water_bottle"
			},
			MSG : {
				BAD : "Tu n’as pas en ta possession de quoi sauver Annie, elle est condamne.",
				GOOD : "Tu as ammene des medicaments, Annie est sauve."
			},
			MSG_END : {
				BAD : "Le fiancee d'Annie, devaster par la disparition de sa dulcine tomba en depression. Son etat le vie passe a cote de son destin qui aurais pu changer le monde.",
				GOOD : "Le fiancee d'Annie a grace a son soutien a remporte les elections de depute. Grace a sa position il participe aux changements en faveur de l'egalite et de l'ecologie."
			}
		},
		"Door_2" : {
			CONDITION : {
				GOOD : "water_bottle",
				BAD : "medkit",
			},
			MSG : {
				GOOD : "Avec ta bouteille d'eau tu a pu arrose une plante",
				BAD : "Tu ne peux rien faire de ces medicament, ils aurait surement ete plus utile ailleurs",
			},
			MSG_END : {
				GOOD : "La plante que tu as arrose est un croisement experimental qui permettra d’endiguer la afin dans le monde.",
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
				GOOD : "Avec ta bouteille d'eau tu a pu arrose une plante",
			},
			MSG_END : {
				GOOD : "La plante que tu as arrose est un croisement experimental qui permettra d’endiguer la afin dans le monde.",
			}
		},
	},
	"Level_5" : {
		PROMPT : "Choisi un remede d’apres les probabilites : Gauche 50% de chance de tous les tue 50% de tous les sauves. Milieu 100% de chance de sauver 20% mais pas plus. Droite 20% de chance de sauver tout le monde, 80 de ne marcher pour personne.",
		"Door_1" : {
			CONDITION : {
				GOOD : "medkit",
				BAD : "medkit_2",
				UGLY : "medkit_3",
			},
			MSG : {
				GOOD : "Tu as eu de la chance, tout le monde est sauf",
				BAD : "Tu as laisse mourir 80% des patient",
				UGLY : "Le remede n’as pas fonctionne…",
			},
			MSG_END : {
				GOOD : "La grande reussite du remede contre l'eclicochis, un virus mortel, a permis d'augmente les finances des laboratoires de recherche.",
				BAD : "La famille des victime des experience contre l'eclicochis, un virus mortel, a fait un recours collectif contre les laboratoires de recherche, mais ont perdu le proces.",
				UGLY : "La famille des victime des experience contre l'eclicochis, un virus mortel, a fait un recours collectif contre les laboratoires de recherche et ont gagner le proces. Resultat la recherche a recule de 10 ans.",
			}
		},
	},
	"Level_6" : {
		PROMPT : "Derriere la porte de gauche ce trouve un enfant hospitalise. Derrière celle du milieu un sdf dépressif et la derniere cache un developpeur. Prend le canard et choisi une porte.",
		"Door_1" : {
			CONDITION : {
				UGLY : "duck",
			},
			MSG : {
				UGLY : "L’enfant et allergique au silicon, tu as tue Ethan.",
			},
			MSG_END : {
				UGLY : "Si Ethan avait survecu, il aurai trouve une nouvel source d'energie verte qui aurait permis d'endiguer le rechaufement climatique",
			}
		},
		"Door_2" : {
			CONDITION : {
				BAD : "duck",
			},
			MSG : {
				BAD : "Tu as donne le canard au sdf, ce qui lui as fais se rendre compte de sa solitude James c’est suicide,",
			},
			MSG_END : {
				BAD : "Une jeune fille a decouvert le cadavre de James. ce qui l'a thraumatisa a vie. Sans cette evenement elle aurai recu un prix nobel de physique.",
			}
		},
		"Door_3" : {
			CONDITION : {
				GOOD : "duck",
			},
			MSG : {
				GOOD : "Antoine a pu expliquer son code au canard, il as ainsi pu le debugger.",
			},
			MSG_END : {
				GOOD : "Son logiciel a permis de prevenir les conflit armee et d’aider a ouvrir la discussion entre les etats,",
			}
		},
	},
	"Level_7" : {
		PROMPT : "Tu trouvera ici un poumon et 3 portes. Derriere chaque porte il y a des patients en attente d’une transplantation. Celle de gauche un cancereux ex fumeur de 50 ans, celle du milieux une petite fille au coeur fragile et la derniere une mere de famille qui viens d’obtenir son badge des 2 ans aux alcooliques anonymes.",
		"Door_1" : {
			CONDITION : {
				GOOD : "lungs",
			},
			MSG : {
				GOOD : "La transplantation de Jonathan c est bien passer.",
			},
			MSG_END : {
				GOOD : "Jonathan n’apportera rien de special au monde mais apportera du bonheur a ces proche.",
			}
		},
		"Door_2" : {
			CONDITION : {
				UGLY : "lungs",
			},
			MSG : {
				UGLY : "Le coeur de Maya etait trop faible, et a fini par cesser de battre. Le poumon dont vous avez prive quelqu’un qui en avait besoin est perdu.",
			},
			MSG_END : {
				UGLY : "Qui sait ce que Maya aurais pu accomplir dans ce monde ?",
			}
		},
		"Door_3" : {
			CONDITION : {
				BAD : "lungs",
			},
			MSG : {
				BAD : "Peut-etre que Jane survivra encore un moment avec ces reins defectueux, Mais le poumon dont vous avez prive quelqu’un qui en avait besoin est perdu.",
			},
			MSG_END : {
				BAD : "Jane aura le temps de dire au revoir a ces proche, mais decedera dans les mois qui suive laissant une famille derriere elle.",
			}
		},
	},
	"Level_8" : {
		PROMPT : "Tu trouvera ici un coeur et 3 portes. Derriere chaque porte il y a des patients en attente d’une transplantation. Celle de gauche un cancereux ex fumeur de 50 ans, celle du milieux une petite fille au coeur fragile et la derniere une mere de famille qui viens d’obtenir son badge des 2 ans aux alcooliques anonymes.",
		"Door_1" : {
			CONDITION : {
				GOOD : "heart",
			},
			MSG : {
				GOOD : "Jonathan n’avait pas besoin de nouveau coeur, mais sa mere si et grace a vous elle a un nouveau coeur.",
			},
			MSG_END : {
				GOOD : "La mere de Jonathan n’apportera rien de special au monde, mais apportera du bonheur a ces proche meme apres la mort de son fils.",
			}
		},
		"Door_2" : {
			CONDITION : {
				UGLY : "heart",
			},
			MSG : {
				UGLY : "Tu as sauve la vie de Maya, mais elle vous regarde avec un regard vide de toute emotion.",
			},
			MSG_END : {
				UGLY : "La bouchere ecarlate, c’est le nom qu’ont donne les journaux a Maya, la plus celebre tueuse en serie de tout les temps",
			}
		},
		"Door_3" : {
			CONDITION : {
				BAD : "heart",
			},
			MSG : {
				BAD : "Peut-etre que Jane survivra encore un moment avec ces reins defectueu, Mais le coeur dont vous avez prive quelqu’un qui en avait besoin est perdu.",
			},
			MSG_END : {
				BAD : "Jane aura le temps de dire au revoir a ces proche, mais decedera dans les mois qui suive laissant une famille derriere elle.",
			}
		},
	},
	"Level_9" : {
		PROMPT : "Tu trouvera ici un rein et 3 portes. Derriere chaque porte il y a des patients en attente d’une transplantation. Celle de gauche un cancereux ex fumeur de 50 ans, celle du milieux une petite fille au coeur fragile et la derniere une mere de famille qui viens d’obtenir son badge des 2 ans aux alcooliques anonymes.",
		"Door_1" : {
			CONDITION : {
				UGLY : "kidney",
			},
			MSG : {
				UGLY : "Un medecin a transplante le rein a Jonathan par erreur, il a fait un rejet et est mort.",
			},
			MSG_END : {
				UGLY : "La famille de Jonathan porta plainte contre l’hôpital ou il a ete tue, l’hôpital du fermer ce qui provoqua de grave consequence pour les habitants.",
			}
		},
		"Door_2" : {
			CONDITION : {
				BAD : "kidney",
			},
			MSG : {
				BAD : "Le coeur de Maya etait trop faible, et a fini par cesser de battre. Le rein dont vous avez prive quelqu’un qui en avait besoin est perdu.",
			},
			MSG_END : {
				BAD : "Qui sait ce que Maya aurais pu accomplir dans ce monde ?",
			}
		},
		"Door_3" : {
			CONDITION : {
				GOOD : "kidney",
			},
			MSG : {
				GOOD : "Vous avez sauve Jane, Grace a vous une famille ne sera pas privee de mere.",
			},
			MSG_END : {
				GOOD : "Jane deviendra une artiste musical reconnue. Elle parlera beaucoup de son alcoolisme et inspira et aida a sortir des addiction de nombreuses personnes",
			}
		},
	},
	"Level_10" : {
		PROMPT : "Choisi un remede d’apres les probabilites : Gauche 50% de chance de tous les tue 50% de tous les sauves. Milieu 100% de chance de sauver 20% mais pas plus. Droite 20% de chance de sauver tout le monde, 80 de ne marcher pour personne.",
		"Door_1" : {
			CONDITION : {
				GOOD : "antidote_green",
				BAD : "antidote_blue",
				UGLY : "antidote_red",
			},
			MSG : {
				GOOD : "Elias est sauve, cette epreuve lui a donne beaucoup d’inspiration",
				BAD : "Le Dr. Murphy est sauve, va t’il pouvoir mener ces recherches a therme ?",
				UGLY : "Tu as sauve le Dr. Hammer, mais il a une personnalite malsaine",
			},
			MSG_END : {
				GOOD : "Grace a Elias le monde est devenue un peu plus beau, il inspirera beaucoup de jeune artistes",
				BAD : "Les recherche du Dr. Murphy n’aboutirons malheureusement jamais, la vie d’un autre aurais pu avoir plus d’impacte sur le monde",
				UGLY : "Le Dr. Hammer est implique dans une affaire sordide de pedophilie",
			}
		},
	},
	"Level_11" : {
		PROMPT : "Choisi un remede d’apres les probabilites : Gauche 50% de chance de tous les tue 50% de tous les sauves. Milieu 100% de chance de sauver 20% mais pas plus. Droite 20% de chance de sauver tout le monde, 80 de ne marcher pour personne.",
		"Door_1" : {
			CONDITION : {
				GOOD : "antidote_green",
				BAD : "antidote_blue",
				UGLY : "antidote_red",
			},
			MSG : {
				GOOD : "Elias est sauve, cette epreuve lui a donne beaucoup d’inspiration",
				BAD : "Le Dr. Murphy est sauve, va t’il pouvoir mener ces recherches a therme ?",
				UGLY : "Tu as sauve le Dr. Hammer, mais il a une personnalite malsaine",
			},
			MSG_END : {
				GOOD : "Grace a Elias le monde est devenue un peu plus beau, il inspirera beaucoup de jeune artistes",
				BAD : "Les recherche du Dr. Murphy n’aboutirons malheureusement jamais, la vie d’un autre aurais pu avoir plus d’impacte sur le monde",
				UGLY : "Le Dr. Hammer est implique dans une affaire sordide de pedophilie",
			}
		},
	},
	"Level_12" : {
		PROMPT : "Choisi un remede d’apres les probabilites : Gauche 50% de chance de tous les tue 50% de tous les sauves. Milieu 100% de chance de sauver 20% mais pas plus. Droite 20% de chance de sauver tout le monde, 80 de ne marcher pour personne.",
		"Door_1" : {
			CONDITION : {
				GOOD : "antidote_green",
				BAD : "antidote_blue",
				UGLY : "antidote_red",
			},
			MSG : {
				GOOD : "Elias est sauve, cette epreuve lui a donne beaucoup d’inspiration",
				BAD : "Le Dr. Murphy est sauve, va t’il pouvoir mener ces recherches a therme ?",
				UGLY : "Tu as sauve le Dr. Hammer, mais il a une personnalite malsaine",
			},
			MSG_END : {
				GOOD : "Grace a Elias le monde est devenue un peu plus beau, il inspirera beaucoup de jeune artistes",
				BAD : "Les recherche du Dr. Murphy n’aboutirons malheureusement jamais, la vie d’un autre aurais pu avoir plus d’impacte sur le monde",
				UGLY : "Le Dr. Hammer est implique dans une affaire sordide de pedophilie",
			}
		},
	},
}

extends Node

enum {GOOD, BAD, UGLY, PROMPT, CONDITION, MSG, MSG_END}

var element_sprites = {
	"blue_potion" : preload("res://assets/items/blue_potion.png"),
	"duck" : preload("res://assets/items/duck.png"),
	"fish" : preload("res://assets/items/fish.png"),
	"medkit" : preload("res://assets/items/medkit.png"),
	"sword": preload("res://assets/items/sword.png")
	}

var end_messages : Array
var end_choises : Array

# a string where the lates message is stored
# once acessed it's forgotten. 
var last_message : String
var last_msg_acess : bool = false

func pop_last_msg():
	if last_msg_acess:
		last_msg_acess = false
		return last_message
	else:
		return null

func add_last_msg(msg):
#	print("adding : ", msg)
	if last_msg_acess:
		print("we didn't print [", last_message, "]")
	last_message = msg
	last_msg_acess = true

func add_message(msg):
	end_messages.append(msg)

func add_choise(choise):
	end_choises.append(choise) 

var responses = {
	"Level_1" : {
		PROMPT : "medoc or a knight, your choice",
		"Door_1" : {
			CONDITION : {
				GOOD : "medkit",
				BAD : "sword",
			},
			MSG : {
				GOOD : "you saved him",
				BAD : "can't save him, might as well stabby stabby",
			},
			MSG_END : {
				GOOD : "he went on to cure cancer",
				BAD : "no cancer cure discovered",
			}
		},
	},
	"Level_2" : {
		PROMPT : "left, go fast and earn big",
		"Door_1" : {
			CONDITION : {
				GOOD : "money",
			},
			MSG : {
				GOOD : "you swapped money for more meds",
			},
			MSG_END : {
				GOOD : "you bought meds with some money",
			}
		},
		"Door_2" : {
			CONDITION : {
				UGLY : "money",
			},
			MSG : {
				UGLY : "try trowing money at the dying man",
			},
			MSG_END : {
				UGLY : "you let the man die but kept your money",
			}
		},
	},
	"Level_3" : {
		PROMPT : "hmm seems straightforward",
		"Door_1" : {
			CONDITION : {
				BAD : "medkit",
				GOOD : "water_bottle"
			},
			MSG : {
				BAD : "asd",
				GOOD : "asdasdjdjdjdjd"
			},
			MSG_END : {
				BAD : "wdn sdfds f",
				GOOD : "jdjdjdj"
			}
		},
		"Door_2" : {
			CONDITION : {
				GOOD : "medkit",
			},
			MSG : {
				GOOD : "yes, another life saved",
			},
			MSG_END : {
				GOOD : "you saved someone, go you",
			}
		},
	},
	"Level_4" : {
		PROMPT : "getting thursty?",
		"Door_1" : {
			CONDITION : {
				BAD : "medkit",
			},
			MSG : {
				BAD : "asd",
			},
			MSG_END : {
				BAD : "wdn sdfds f",
			}
		},
		"Door_2" : {
			CONDITION : {
				GOOD : "medkit",
			},
			MSG : {
				GOOD : "yes, another life saved",
			},
			MSG_END : {
				GOOD : "you saved someone, go you",
			}
		},
	},
}

extends Node

var element_sprites = {
	"blue_potion" : preload("res://assets/items/blue_potion.png"),
	"duck" : preload("res://assets/items/duck.png"),
	"fish" : preload("res://assets/items/fish.png"),
	"medkit" : preload("res://assets/items/medkit.png"),
	"sword": preload("res://assets/items/sword.png")
	}

enum {GOOD, BAD, UGLY}

var responces = {
	"level_1" : {
		GOOD : "well done you didn't kill the junky",
		BAD : "you tried but the junky died",
		UGLY : "junky dies, but who cares"
	},
	"level_2" : {
		GOOD : "you went left great work",
		BAD : "you went right, boo",
		UGLY : "try bring some items next time"
	},
	"level_3" : {
		GOOD : "hmm something sarcastic",
		BAD : "something snarky",
		UGLY : "outright personall attacks"
	},
	"level_4" : {
		GOOD : "good lvl 4",
		BAD : "bad 4",
		UGLY : "ugly 4"
	},
	"level_5" : {
		GOOD : "good lvl 5",
		BAD : "bad 5",
		UGLY : "uugly 5"
	},
	"level_6" : {
		GOOD : "good lvl 6",
		BAD : "bad 6",
		UGLY : "ugly 6"
	},
}

var level_result

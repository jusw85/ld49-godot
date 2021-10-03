extends Node

onready var card  = $Card


func fade(fade):
	if fade:
		card.fade(true)
	else:
		card.fade(false)

extends Node

onready var card  = $Card


func fade(visible):
	if visible:
		card.unfade()
	else:
		card.fade()

extends Node

signal cards_selected(selected)  # main

var _num_selected = 0

onready var cards = $CardsGroup
#onready var selected = $SelectedCard

# Called when the node enters the scene tree for the first time.
func _ready():
	for card in cards.get_children():
		card.connect("card_selected", self, "_on_Card_card_selected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	pass
#	if event.is_action_pressed("ui_accept"):
#		fade_unselected()
#	if event is InputEventMouseButton and event.pressed == true :
#		print(event.position)
#		print(event.global_position)

func fade_all():
	for card in cards.get_children():
		card.fade()

func unfade_all():
	for card in cards.get_children():
		card.unfade()

func fade_unselected():
	for card in cards.get_children():
		if not card.is_selected:
			card.fade()

#func show_selected(visible):
#	if visible:
#		selected.unfade()
#	else:
#		selected.fade()

func _on_Card_card_selected(is_selected):
	assert(_num_selected <= 2 and _num_selected >= 0)
	if is_selected:
		_num_selected += 1
		if _num_selected >= 2:
			_lock_cards(true)
			emit_signal("cards_selected", true)
	else:
		_num_selected -= 1
		if _num_selected < 2:
			_lock_cards(false)
			emit_signal("cards_selected", false)
#	print(_num_selected)


func _lock_cards(is_lock):
	for card in cards.get_children():
		card.can_select = not is_lock

extends Node

signal cards_selected(selected)  # main

var _selected_idx = -1
var _num_selected = 0
var _selected = [false, false, false, false]

onready var cards = $CardsGroup.get_children()


func _ready():
	for i in range(0, cards.size()):
		cards[i].idx = i
		cards[i].connect("is_clicked", self, "_on_Card_is_clicked")


func set_data(idx, data, card_idx):
	cards[idx].set_data(data, card_idx)


func fade_all():
	for card in cards:
		card.fade(true)

func unfade_all():
	for card in cards:
		card.fade(false)

func reset():
	cards[_selected_idx].slide(false, true)
	_num_selected = 0
	_selected = [false, false, false, false]

func _on_Card_is_clicked(idx):
	if not _selected[idx] and _num_selected < 1:
		_selected_idx = idx
		_selected[idx] = true
		cards[idx].slide(true)
		_num_selected += 1
		if _num_selected == 1:
			emit_signal("cards_selected", true)
	elif _selected[idx]:
		_selected_idx = -1
		_selected[idx] = false
		cards[idx].slide(false)
		_num_selected -= 1
		emit_signal("cards_selected", false)

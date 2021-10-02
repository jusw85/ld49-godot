extends Node

signal cards_selected(selected)  # main

var _num_selected = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	for card in get_children():
		card.connect("card_selected", self, "_on_Card_card_selected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
	for card in get_children():
		card.can_select = not is_lock

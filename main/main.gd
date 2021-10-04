extends Node2D

signal lumber_changed(lumber)

enum State { PICKING, RESPONSE }
var state = State.PICKING
var is_building_next_turn = false

var rng = RandomNumberGenerator.new()

var cards_data = []
var seen_cards = []
# Teriyaki, Tenders, Cluck, Eggstein,
# Bacon, Wiggly, Ham, Harry,
# Billy, Nanny, Goatse, Ramsey
# Lumber
var resources = []

onready var go = $Go
onready var anim = $AnimationPlayer
onready var viewport = $"Viewports/4cards"
onready var cards = $"Viewports/4cards/Cards"

onready var next = $CanvasLayer/Next

func _ready():
	randomize()
	rng.randomize()
	for _i in range(12):
		resources.append(50)
	resources.append(0)
	for i in range(44):
		cards_data.append(load("res://cards/card" + str(i) + ".tres"))
		seen_cards.append(false)

	rand_cards()


func _unhandled_input(event):
	if state == State.RESPONSE and NC.EventUtils.is_lclick(event):
		_on_Next_pressed()
	else:
		viewport.unhandled_input(event)


func get_available_cards():
	var arr = []
#	for i in range(0, cards_data.size()):
	for i in range(1, 37):
		var avail = true
		for prereq in cards_data[i].prereq_cards:
			if not seen_cards[prereq]:
				avail = false
				break
		if avail:
			arr.append(i)
	if resources[12] >= 10:
		arr.append(43)
	return arr


func rand_cards():
#	var arr = []
#	for i in range(0, cards_data.size()):
#		arr.append(i)
	if is_building_next_turn:
		is_building_next_turn = false
		cards.set_data(0, cards_data[37], 37)
		cards.set_data(1, cards_data[38], 38)
		cards.set_data(2, cards_data[39], 39)
		cards.set_data(3, cards_data[40], 40)
		return

	var arr = get_available_cards()

	for i in range(0, 4):
#		print(arr)
		arr.shuffle()
#		print(arr)
		var idx = arr.pop_back()
#		if idx == 99:
#			cards.set_data(0, cards_data[37], 37)
#			cards.set_data(1, cards_data[38], 38)
#			cards.set_data(2, cards_data[39], 39)
#			cards.set_data(3, cards_data[40], 40)
#			break
#		else:
#			cards.set_data(i, cards_data[idx], idx)
		cards.set_data(i, cards_data[idx], idx)


func _on_Go_pressed():
	$Control/Panel.visible = false
	$Control/Panel/Panel2/Description.text = ""
	anim.play("fade_in")
#	next.visible = true
#	go.visible = false
	cards.fade_all()
	yield(get_tree().create_timer(1.0), "timeout")

	var card = cards.cards[cards._selected_idx]

	if card.card_idx == 43:
		is_building_next_turn = true

	$"Control/Response".text = card.response
	seen_cards[card.card_idx] = true
	for i in range(13):
		resources[i] += card.resource_changes[i]
	if card.resource_changes[12] != 0:
		emit_signal("lumber_changed", resources[12])

	cards.reset()
	rand_cards()

	state = State.RESPONSE
#	$"Viewports/1card/Card".fade(false)


func _on_Cards_cards_selected(selected):
#	go.visible = selected
	_on_Go_pressed()


func _on_Next_pressed():
	anim.play_backwards("fade_in")
#	next.visible = false
	cards.unfade_all()
	$"Control/Response".text = ""
	state = State.PICKING

#	$"Viewports/1card/Card".fade(true)


func _on_Card_show_text(text):
	if text == "":
		$Control/Panel.visible = false
	else:
		$Control/Panel.visible = true
		$Control/Panel/Panel2/Description.text = text

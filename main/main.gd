extends Node2D

signal lumber_changed(lumber)

enum State { PICKING, RESPONSE }
var state = State.PICKING

var rng = RandomNumberGenerator.new()

var cards_data = []
var seen_cards = []
var lumber = 0

onready var go = $Go
onready var anim = $AnimationPlayer
onready var viewport = $"Viewports/4cards"
onready var cards = $"Viewports/4cards/Cards"

onready var next = $CanvasLayer/Next

func _ready():
	randomize()
	rng.randomize()
	for i in range(1, 43):
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
	for i in range(0, 36):
		var avail = true
		for prereq in cards_data[i].prereq_cards:
			if not seen_cards[prereq]:
				avail = false
				break
		if avail:
			arr.append(i)
	if lumber >= 10:
		arr.append(99)
	return arr


func rand_cards():
#	var arr = []
#	for i in range(0, cards_data.size()):
#		arr.append(i)
	var arr = get_available_cards()

	for i in range(0, 4):
		arr.shuffle()
		var idx = arr.pop_back()
		if idx == 99:
			cards.set_data(0, cards_data[36].front_face, cards_data[36].text, cards_data[36].response, 36)
			cards.set_data(1, cards_data[37].front_face, cards_data[37].text, cards_data[37].response, 37)
			cards.set_data(2, cards_data[38].front_face, cards_data[38].text, cards_data[38].response, 38)
			cards.set_data(3, cards_data[39].front_face, cards_data[39].text, cards_data[39].response, 39)
			break
		else:
			cards.set_data(i, cards_data[idx].front_face, cards_data[idx].text, cards_data[idx].response, idx)


func _on_Go_pressed():
	$Control/Description.text = ""
	anim.play("fade_in")
#	next.visible = true
	go.visible = false
	cards.fade_all()
	yield(get_tree().create_timer(1.0), "timeout")

	var res = cards.cards[cards._selected_idx].response
	$"Control/Response".text = res

	var idx = cards.cards[cards._selected_idx].card_idx
	seen_cards[idx] = true

	cards.reset()
	rand_cards()

	state = State.RESPONSE

#	add_lumber(10)
#	$"Viewports/1card/Card".fade(false)


func add_lumber(amount):
	lumber += amount
	emit_signal("lumber_changed", amount)


func _on_Cards_cards_selected(selected):
	go.visible = selected


func _on_Next_pressed():
	anim.play_backwards("fade_in")
#	next.visible = false
	cards.unfade_all()
	$"Control/Response".text = ""
	state = State.PICKING

#	$"Viewports/1card/Card".fade(true)


func _on_Card_show_data(data):
	$Control/Description.text = data

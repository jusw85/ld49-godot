extends Node2D


enum State { PICKING, RESPONSE }
var state = State.PICKING

var rng = RandomNumberGenerator.new()

var cards_data = []

onready var go = $Go
onready var anim = $AnimationPlayer
onready var viewport = $"Viewports/4cards"
onready var cards = $"Viewports/4cards/Cards"

onready var next = $CanvasLayer/Next

func _ready():
	randomize()
	rng.randomize()
	for i in range(1, 13):
		cards_data.append(load("res://cards/card" + str(i) + ".tres"))

	rand_cards()


func _unhandled_input(event):
	if state == State.RESPONSE and NC.EventUtils.is_lclick(event):
		_on_Next_pressed()
	else:
		viewport.unhandled_input(event)


func rand_cards():
	var arr = []
	for i in range(0, cards_data.size()):
		arr.append(i)

	for i in range(0, 4):
		arr.shuffle()
		var idx = arr.pop_back()
		cards.set_data(i, cards_data[idx].front_face, cards_data[idx].text, cards_data[idx].response)


func _on_Go_pressed():
	$Control/Description.text = ""
	anim.play("fade_in")
#	next.visible = true
	go.visible = false
	cards.fade_all()
	yield(get_tree().create_timer(1.0), "timeout")

	var obj = $"Viewports/4cards/Cards"
	var res = obj.cards[obj._selected_idx].response
	$"Control/Response".text = res

	cards.reset()
	rand_cards()

	state = State.RESPONSE

#	$"Viewports/1card/Card".fade(false)


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

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (Array, Resource) var cards_data

onready var go = $Go
onready var anim = $AnimationPlayer
onready var viewport = $"Viewports/4cards"
onready var cards = $"Viewports/4cards/Cards"

onready var next = $CanvasLayer/Next

func _ready():
	for i in range(0, 4):
		cards.set_data(i, cards_data[i].front_face, cards_data[i].text, cards_data[i].response)


func _unhandled_input(event):
	viewport.unhandled_input(event)


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
#	$"Viewports/1card/Card".fade(false)


func _on_Cards_cards_selected(selected):
	go.visible = selected


func _on_Next_pressed():
	anim.play_backwards("fade_in")
	next.visible = false
	cards.unfade_all()
	$"Control/Response".text = ""
#	$"Viewports/1card/Card".fade(true)
#	cards.show_selected(false)


func _on_Card_show_data(data):
	$Control/Description.text = data

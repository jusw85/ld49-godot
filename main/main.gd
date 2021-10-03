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

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, 4):
		cards.set_data(i, cards_data[i].front_face, cards_data[i].text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	viewport.unhandled_input(event)


func _on_Go_pressed():
	$Control/Description.text = ""
	anim.play("fade_in")
	next.visible = true
	go.visible = false
	cards.fade_all()
	yield(get_tree().create_timer(1.0), "timeout")
	$"Viewports/1card/Card".fade(false)
	$"Control/Response".text = "DF"
#	anim2.play("fade_out")
#	cards.fade_unselected()
#	cards.show_selected(true)


func _on_Cards_cards_selected(selected):
	go.visible = selected


func _on_Next_pressed():
	anim.play_backwards("fade_in")
	next.visible = false
	cards.unfade_all()
	$"Viewports/1card/Card".fade(true)
	$"Control/Response".text = ""
#	cards.show_selected(false)


func _on_Card_show_data(data):
	$Control/Description.text = data

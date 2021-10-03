extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var go = $Go
onready var anim = $AnimationPlayer
onready var anim2 = $"4cards/4cards/AnimationPlayer"
onready var viewport = $"4cards/Viewport"
onready var cards = $"4cards/Viewport/Cards"

onready var next = $CanvasLayer/Next

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	viewport.unhandled_input(event)


func _on_Go_pressed():
	anim.play("fade_in")
	next.visible = true
	go.visible = false
	cards.fade_all()
	yield(get_tree().create_timer(1.0), "timeout")
	$Viewport/Card.fade(false)
#	anim2.play("fade_out")
#	cards.fade_unselected()
#	cards.show_selected(true)


func _on_Cards_cards_selected(selected):
	go.visible = selected


func _on_Next_pressed():
	anim.play_backwards("fade_in")
	next.visible = false
	cards.unfade_all()
	$Viewport/Card.fade(true)
#	cards.show_selected(false)

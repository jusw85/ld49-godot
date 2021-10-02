extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var go = $Go
onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Go_pressed():
	anim.play("fade_in")
	go.visible = false



func _on_Cards_cards_selected(selected):
	go.visible = selected


func _on_Next_pressed():
	anim.play("fade_out")

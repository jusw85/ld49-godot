extends Node2D

signal card_selected(is_selected)  # cards

var can_select = true
var is_selected = false

export var texture: Texture

onready var anim = $AnimationPlayer
onready var sprite = $Node2D/Sprite


func _ready():
	sprite.texture = texture


func is_lclick(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			return true
	return false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if is_lclick(event):
		if can_select and not is_selected:
			is_selected = true
			anim.play("slide")
			emit_signal("card_selected", true)
		elif is_selected:
			is_selected = false
			anim.play_backwards("slide")
			emit_signal("card_selected", false)


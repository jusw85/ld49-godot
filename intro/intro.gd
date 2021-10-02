extends Node


export(Array, String, MULTILINE) var texts
export(Array, Texture) var bgs

onready var rect: TextureRect = $CanvasLayer/TextureRect
onready var label: Label = $CanvasLayer/Label
onready var anim: AnimationPlayer = $AnimationPlayer

var _idx = 0

func _ready():
	_update_bg()


func _unhandled_input(event):
	if is_lclick(event):
		anim.play("fader")


func is_lclick(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			return true
	return false


func _change_screen():
	_idx += 1
	if _idx < texts.size():
		_update_bg()
	else:
		get_tree().change_scene("res://main/main.tscn")


func _update_bg():
	rect.texture = bgs[_idx]
	label.text = texts[_idx]

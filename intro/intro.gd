extends Node


#onready var tween: Tween = $Tween
onready var rect: ColorRect = $CanvasLayer/ColorRect
onready var anim: AnimationPlayer = $AnimationPlayer


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		anim.play("fader")

func _change_screen():
	print("change screen")

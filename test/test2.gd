extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var texture = $Viewport.get_texture()
#	$icon.texture = texture



func _unhandled_input(event):
	$Viewport.unhandled_input(event)

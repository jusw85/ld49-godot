extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		$AnimationPlayer.play("flip")
	elif event.is_action_pressed("ui_right"):
		$AnimationPlayer.play("fade")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

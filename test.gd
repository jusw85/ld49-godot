extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _input(event):
	pass
#	print(event)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		$AnimationPlayer.play("flip")
	elif event.is_action_pressed("ui_right"):
		$AnimationPlayer.play("fade")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func is_lclick(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			return true
	return false


func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if is_lclick(event):
		print("click")


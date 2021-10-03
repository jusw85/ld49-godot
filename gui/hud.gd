extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func change_lumber(lumber):
	$VBoxContainer/Label.text = "Lumber: " + str(lumber)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Main_lumber_changed(lumber):
	change_lumber(lumber)

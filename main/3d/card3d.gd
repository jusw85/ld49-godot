extends Spatial

signal card_selected(is_selected)  # cards

var can_select = true
var is_selected = false

onready var anim: AnimationPlayer = $AnimationPlayer
onready var area: Area = $Spatial/Area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func fade():
	area.visible = false
	anim.play("fade")


func unfade():
	area.visible = true
	anim.play_backwards("fade")


func _on_Area_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if NC.EventUtils.is_lclick(event):
		if can_select and not is_selected:
			is_selected = true
			anim.play("slide")
			emit_signal("card_selected", true)
		elif is_selected:
			is_selected = false
			anim.play_backwards("slide")
			emit_signal("card_selected", false)

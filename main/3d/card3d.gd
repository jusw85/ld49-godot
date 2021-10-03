extends Spatial

signal show_data(data)
signal card_selected(is_selected)  # cards

var can_select = true
var is_selected = false
var data = ""

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


func set_face(texture: Texture):
	var mat = $Spatial/FrontFace.get_active_material(0)
	mat.albedo_texture = texture


func _on_Area_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if NC.EventUtils.is_lclick(event):
		emit_signal("show_data", data)
		if can_select and not is_selected:
			is_selected = true
			anim.play("slide")
			emit_signal("card_selected", true)
		elif is_selected:
			is_selected = false
			anim.play_backwards("slide")
			emit_signal("card_selected", false)


func _on_Area_mouse_entered():
	emit_signal("show_data", data)


func _on_Area_mouse_exited():
	emit_signal("show_data", "")

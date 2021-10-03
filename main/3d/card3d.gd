extends Spatial

signal show_data(data)
signal is_clicked(idx)

var idx = 0
var is_slided = false
var is_faded = false

var card_idx = 0
var data = ""
var response = ""

onready var anim: AnimationPlayer = $AnimationPlayer
onready var area: Area = $Spatial/Area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func fade(do_fade: bool):
	if do_fade:
		is_faded = true
		area.visible = false
		anim.play("fade")
	else:
		is_faded = false
		area.visible = true
		anim.play_backwards("fade")


func slide(do_slide: bool):
	if do_slide and not is_slided:
		is_slided = true
		anim.play("slide")
	elif not do_slide and is_slided:
		is_slided = false
		anim.play_backwards("slide")


func set_face(front: Texture, back: Texture):
	$Spatial/FrontFace.get_active_material(0).albedo_texture = front
	$Spatial/BackFace.get_active_material(0).albedo_texture = back


func _on_Area_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if NC.EventUtils.is_lclick(event):
		emit_signal("is_clicked", idx)
		emit_signal("show_data", data)


func _on_Area_mouse_entered():
	emit_signal("show_data", data)


func _on_Area_mouse_exited():
	emit_signal("show_data", "")

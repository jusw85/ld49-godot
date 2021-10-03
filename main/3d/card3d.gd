extends Spatial

signal show_text(text)
signal is_clicked(idx)

var idx = 0
var is_slided = false
var is_faded = false

var card_idx = 0
var text = ""
var response = ""
var resource_changes = []

onready var fade_anim: AnimationPlayer = $FadeAnimationPlayer
onready var slide_anim: AnimationPlayer = $SlideAnimationPlayer
onready var area: Area = $Spatial/Area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func fade(do_fade: bool):
	if do_fade:
		is_faded = true
		area.visible = false
		fade_anim.play("fade")
	else:
		is_faded = false
		area.visible = true
		fade_anim.play_backwards("fade")


func slide(do_slide: bool, instant = false):
	if do_slide and not is_slided:
		is_slided = true
		if instant:
			$Spatial.translation = Vector3(0.0, 0.5, 0.0)
		else:
			slide_anim.play("slide")
	elif not do_slide and is_slided:
		is_slided = false
		if instant:
			$Spatial.translation = Vector3.ZERO
		else:
			slide_anim.play_backwards("slide")


func set_data(data, p_card_idx):
	set_face(data.front_face, data.front_face)
	text = data.text
	response = data.response
	resource_changes = data.resource_changes
	card_idx = p_card_idx



func set_face(front: Texture, back: Texture):
	$Spatial/FrontFace.get_active_material(0).albedo_texture = front
	$Spatial/BackFace.get_active_material(0).albedo_texture = back


func _on_Area_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if NC.EventUtils.is_lclick(event):
		emit_signal("is_clicked", idx)
		emit_signal("show_text", text)


func _on_Area_mouse_entered():
	emit_signal("show_text", text)


func _on_Area_mouse_exited():
	emit_signal("show_text", "")

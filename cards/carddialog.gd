extends Resource
class_name CardDialog

export var front_face: Texture
export(String, MULTILINE) var text
export(String, MULTILINE) var response
export(Array, int) var prereq_cards
export(Array, int) var resource_changes
export var repeatable: bool

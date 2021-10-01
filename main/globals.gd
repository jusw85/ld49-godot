extends Node

var _config


# load config here
func _init():
	pass
#	.ini doesn't show in filesystem dock
#	https://github.com/godotengine/godot-proposals/issues/677
#   .tres has to be used for embedding as resource in web

#	_config = ConfigFile.new()
#	var err = _config.load("res://config/config.tres")
#	assert(err == OK)

class_name Main

extends Node

@export var background_color: Color


func _ready():
	RenderingServer.set_default_clear_color(background_color)

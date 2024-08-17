extends Control

@onready var meeple_level = %Level
@onready var texture = %Texture

func set_meeple_level(level: int):
	meeple_level.text = str(level)

func set_color(color : Color):
	texture.modulate = color
	

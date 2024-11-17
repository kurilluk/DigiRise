extends Control

@onready var _lvl_label = %Level_label
@onready var _texture = %Texture
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _lvl_num: int = -1
var _color: Color = Color("404040")

## To setup basic values after is instanciated
func setup(level: int = -1, color: Color = Color("404040")):
	_lvl_num = level
	_color = color

## Preview values on nodes when cursor is added to scene as child
func _ready():
	_lvl_label.text = str(_lvl_num)
	_texture.modulate = _color

@tool
class_name Meeple extends PanelContainer

const MEEPLE_CURSOR =  preload("res://objects/cursor/meeple_cursor.tscn")
const MEEPLE_TEXTURE = preload("res://objects/meeple/Meeple_rect.svg")

@onready var price_label = %Price_label
@onready var lvl_label = %Level_label
@onready var meeple_texture = %Meeple_texture

@export var type: MM.TYPES = MM.TYPES.INTERNAL:
	set(value):
		type = value
		update_visuals()

@export var level: int = -1:
	set(value):
		level = value
		update_visuals()

#var _level: int = -1
var _price: int = 0
#var _slot : Slot = null
var _color: Color
#var _type: MM.TYPES

#func _init(level: int, slot: Slot, type: MM.TYPES):
	#_level = level
	#_price = MM.get_price(level)
	#_slot = slot
	#_type = type
	#_color = MM.COLORS[type]

#func setup(type_new: MM.TYPES, level: int, slot: Slot) -> void:
	##_level = level
	#_price = MM.get_price(level)
	#_slot = slot
	##_type = type
	#_color = MM.COLORS[type]

func _ready():
	meeple_texture.texture = MEEPLE_TEXTURE
	#_type = type
	_color = MM.COLORS[type]
	meeple_texture.modulate = _color
	#_level = level
	_price = MM.get_price(level)
	update_visuals()

func update_visuals():
	if type == MM.TYPES.EMPTY:
		#price_label.visible = false
		self.mouse_default_cursor_shape = Control.CURSOR_ARROW
	else:
		#price_label.visible = true
		self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	_color = MM.COLORS[type]

	if meeple_texture:
		meeple_texture.modulate = _color
	update_text()

func update_text():
	if type == MM.TYPES.EMPTY:
		lvl_label.text = "---"
		price_label.text = "---"
	else:
		if lvl_label:
			lvl_label.text = "%s" % [level]
		_price = MM.get_price(level)
		if price_label:
			price_label.text = "%s" % [_price]

func get_price() -> int:
	return _price
 
func get_level() -> int:
	return level
	
func get_type() -> MM.TYPES:
	return type


### DRAG DATA
func _get_drag_data(_at_position):
	if type == MM.TYPES.EMPTY:
		return null
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_drag_preview(make_drag_preview())
	return self
	 
func make_drag_preview() -> Control:
	var preview = MEEPLE_CURSOR.instantiate()
	preview.setup(level,_color) #MM.COLORS[type]
	return preview
	

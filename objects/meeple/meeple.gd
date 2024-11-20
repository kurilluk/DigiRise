#@tool
class_name Meeple extends Control

const MEEPLE_CURSOR =  preload("res://objects/cursor/meeple_cursor.tscn")
const MEEPLE_TEXTURE = preload("res://objects/meeple/Meeple_rect.svg")
@onready var sound: AudioStreamPlayer = $Sound

#@onready var price_label = %Price_value
#@onready var lvl_label = %Level_value
#@onready var meeple_texture = %Meeple_texture

@export var meeple_type: MM.TYPES = MM.TYPES.EMPTY:
	set(value):
		meeple_type = value
		update_visuals()

@export var meeple_level: int = 0:
	set(value):
		meeple_level = value
		update_visuals()

var _price: int = 0
var _color: Color

func set_meeple_level(level_value : int) -> void:
	self.meeple_level = level_value

func set_meeple_type(type_value : MM.TYPES):
	self.meeple_type = type_value

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

#func _ready():
	#meeple_texture.texture = MEEPLE_TEXTURE
	##_type = type
	#_color = MM.COLORS[type]
	#meeple_texture.modulate = _color
	##_level = level
	#_price = MM.get_price(level)
	#update_visuals()
#
func update_visuals():
	print("I AM INSIDE MEEPLE NOT SLOT!")
	pass
	#if type == MM.TYPES.EMPTY:
		##price_label.visible = false
		#self.mouse_default_cursor_shape = Control.CURSOR_ARROW
	#else:
		##price_label.visible = true
		#self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	#_color = MM.COLORS[type]
#
	#if meeple_texture:
		#meeple_texture.modulate = _color
	#update_text()
#
#func update_text():
	#if type == MM.TYPES.EMPTY:
		#lvl_label.text = "---"
		#price_label.text = "---"
	#else:
		#if lvl_label:
			#lvl_label.text = "%s" % [level]
		#_price = MM.get_price(level)
		#if price_label:
			#price_label.text = "%s" % [_price]

func get_price() -> int:
	return _price
 
func get_level() -> int:
	return meeple_level
	
func get_type() -> MM.TYPES:
	return meeple_type

func is_eployee() -> bool:
	return true if meeple_type == MM.TYPES.INTERNAL else false

### DRAG DATA
func _get_drag_data(_at_position):
	if meeple_type == MM.TYPES.EMPTY:
		return null
	SoundManager.play_drag_click(sound)
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_drag_preview(make_drag_preview())
	return self
	 
func make_drag_preview() -> Control:
	var preview = MEEPLE_CURSOR.instantiate()
	preview.setup(meeple_level,_color) #MM.COLORS[type]
	return preview
	

#@tool
class_name Meeple extends Control

const MEEPLE_CURSOR =  preload("res://objects/cursor/meeple_cursor.tscn")
const MEEPLE_TEXTURE = preload("res://objects/meeple/Meeple_rect.svg")

@onready var meeple_sound: AudioStreamPlayer = $Meeple_sound
@onready var upskill_icon: Label = %Upskill_icon
@onready var upskill_icon2: Label = %Upskill_icon2

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
var _is_locked: bool = false
var _upskill: int = -1

func lock_meeple(value : bool = true):
	#if value:
		#SoundManager.play_sound(meeple_sound,SoundManager.SOUND_LOCK) # TODO unlock valuce
	_is_locked = value

func set_meeple_upskill(upskill_value: int):
	if _upskill != upskill_value:
		_upskill = upskill_value
		# TODO animation here
		if upskill_value == 2:
			upskill_icon.visible = true
			upskill_icon2.visible = true
		elif upskill_value == 1:
			upskill_icon.visible = true
			upskill_icon2.visible = false
		else:
			upskill_icon.visible = false
			upskill_icon2.visible = false

func get_meeple_upskill() -> int:
	return _upskill

func reset_meeple_upskill():
	_upskill = 0


func set_meeple_level(level_value : int) -> void:
	self.meeple_level = level_value

func set_meeple_type(type_value : MM.TYPES):
	self.meeple_type = type_value

func get_meeple_price() -> int:
	return _price
 
func get_meeple_level() -> int:
	return meeple_level
	
func get_meeple_type() -> MM.TYPES:
	return meeple_type

func is_eployee() -> bool:
	return true if meeple_type == MM.TYPES.INTERNAL or meeple_type == MM.TYPES.NEW else false

func update_visuals():
	print("I AM INSIDE MEEPLE NOT SLOT!")
	pass

### DRAG DATA
func _get_drag_data(_at_position):
	if meeple_type == MM.TYPES.EMPTY or _is_locked:
		return null
	SFX.play(SFX.SOUND_DRAG)
	#SoundManager.play_drag_click(meeple_sound)
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_drag_preview(make_drag_preview())
	return self
	 
func make_drag_preview() -> Control:
	var preview = MEEPLE_CURSOR.instantiate()
	preview.setup(meeple_level,_color) #MM.COLORS[type]
	return preview
	

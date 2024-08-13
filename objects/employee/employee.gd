class_name Employee extends Control

#@onready var sound = $Sound

@onready var req_level = %Req_Level
@onready var price = %Price
@onready var level = %Level
@onready var meeple = %Meeple

const MEEPLE_CURSOR = preload("res://objects/employee/meeple_cursor.tscn")
const Meeple_texture = preload("res://assets/vectors/MeepleCustom5.svg") 
const Meeple_drag_texture = preload("res://assets/vectors/MeepleCustom4.svg") 

var _level_number: int = -1
var _level_price: int = -1
var _required_level: int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	level.text = "---"
	price.text = "---"
	req_level.text = ""

func set_requred_level_number(level_num: int) -> void:
	_required_level = level_num
	req_level.text = "%s" % [_required_level]

func set_level_number(level_num: int) -> void:
	_level_number = level_num
	_level_price = GameManager.PRICES[_level_number]
	level.text = "%s" % [_level_number]
	price.text = "%s" % [_level_price]

func load_texture():
	meeple.texture = Meeple_texture
 
### DRAG DATA
func _get_drag_data(_at_position):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if meeple.texture == null:
		return null
	set_drag_preview(make_drag_preview())
	return self
	 
### DROP DATA
func _can_drop_data(_pos, data):
	if data is Employee:
		if _required_level <= data._level_number:
			return true
		
	return false
	#typeof(data) == 
	#data is Texture2D
 
func _drop_data(_pos, data):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if meeple.texture == null: # no Meeple
		update_data(data)
	elif _level_number >= data._required_level:  # check if new swithced meeple will not have lower level as required
		switch_data(data)
	else:
		print("Swith is not possible - you cannot downgrade level of meeple (on that spot)! >> play sound - wrong")
		return
	SignalManager.on_project_meeple_change.emit()
	
	#var temp = self.texture
	#texture = data.texture
	##if data != self:
	#data.texture = temp
	
func switch_data(new_data : Employee):
	var temp_level = _level_number
	set_level_number(new_data._level_number)
	new_data.set_level_number(temp_level)

func update_data(new_data : Employee):
	load_texture()
	set_level_number(new_data._level_number)
	
	new_data.meeple.texture = null
	unload_level_data(new_data)

func unload_level_data(data: Employee):
	data._level_number = -1
	data._level_price = -1
	#label.text = "%sx%s" % [l_data.rows, l_data.cols]
	data.level.text = "---"
	data.price.text = "---"

	
func make_drag_preview() -> Control:
	var preview_texture = TextureRect.new()
 
	#preview_texture.texture = Meeple_drag_texture
	#preview_texture.expand_mode = 1
	#preview_texture.size = Vector2(130,130)
 
	#var preview = Control.new()
	var preview = MEEPLE_CURSOR.instantiate() 
	preview.add_child(preview_texture)
	preview.set_meeple_level(_level_number)
	#preview_texture.position = -0.5 * preview_texture.size
	return preview
	
#func _on_pressed():
	#SoundManager.play_button_click(sound)
	#SignalManager.on_level_selected.emit(_level_number)

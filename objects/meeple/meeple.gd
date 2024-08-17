class_name Meeple extends TextureRect

const MEEPLE_CURSOR = preload("res://objects/employee/meeple_cursor.tscn")
const Meeple_texture = preload("res://assets/vectors/MeepleCustom5.svg") 
const Meeple_drag_texture = preload("res://assets/vectors/MeepleCustom4.svg") 

var _level: int = 1
var _price: int = 0
#var _external: bool
var slot : Slot = null

# Called when the node enters the scene tree for the first time.
#func _ready():
	#level.text = "---"
	#price.text = "---"
	#req_level.text = ""
	#_external = false

func set_level_number(level_num: int) -> void:
	_level = level_num
	_price = GameManager.PRICES[_level]
	#level.text = "%s" % [_level_number]
	#price.text = "%s" % [_level_price]

func load_texture():
	self.texture = Meeple_texture
	
func get_price() -> int:
	return _price
 
### DRAG DATA
func _get_drag_data(_at_position):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if self.texture == null:
		return null
	set_drag_preview(make_drag_preview())
	return self
	 
#### DROP DATA
#func _can_drop_data(_pos, data):
	#if data is Employee:
		#if _required_level <= data._level_number:
			#return true
		#
	#return false
	##typeof(data) == 
	##data is Texture2D
 #
#func _drop_data(_pos, data):
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#if meeple.texture == null: # no Meeple
		#update_data(data)
	#elif _level_number >= data._required_level:  # check if new swithced meeple will not have lower level as required
		#switch_data(data)
	#else:
		#print("Swith is not possible - you cannot downgrade level of meeple (on that spot)! >> play sound - wrong")
		#return
	#SignalManager.on_project_meeple_change.emit()
	#
	##var temp = self.texture
	##texture = data.texture
	###if data != self:
	##data.texture = temp
	
#func empty_data():
	#meeple.texture = null
	#_level_number = -1
	#_level_price = 0
	#level.text = "---"
	#price.text = "---"
	#_external = false
	
#func switch_data(new_data : Employee):
	#var temp_level = _level_number
	#set_level_number(new_data._level_number)
	#new_data.set_level_number(temp_level)
#
#func update_data(new_data : Employee):
	#load_texture()
	#set_level_number(new_data._level_number)
	#
	#new_data.meeple.texture = null
	#unload_level_data(new_data)
#
#func unload_level_data(data: Employee):
	#data._level_number = -1
	#data._level_price = 0
	##label.text = "%sx%s" % [l_data.rows, l_data.cols]
	#data.level.text = "---"
	#data.price.text = "---"

	
func make_drag_preview() -> Control:
	#var preview_texture = TextureRect.new()
 
	#preview_texture.texture = Meeple_drag_texture
	#preview_texture.expand_mode = 1
	#preview_texture.size = Vector2(130,130)
 
	#var preview = Control.new()
	var preview = MEEPLE_CURSOR.instantiate()
	preview.get_node("Texture").modulate = self.modulate
	preview.get_node("Level").text = str(self._level) 
	#preview.add_child(icon)
	#add_child(preview)
	#icon.set_meeple_level(_level)
	#icon.set_color(self.modulate)
	#preview_texture.position = -0.5 * preview_texture.size
	return preview
	
#func _on_pressed():
	#SoundManager.play_button_click(sound)
	#SignalManager.on_level_selected.emit(_level_number)

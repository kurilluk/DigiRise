class_name Slot extends Control

#@onready var sound = $Sound

@onready var min_lvl_label = %Min_level_label
#@onready var price_label = %Price_label
#@onready var lvl_label = %Level_label
@onready var meeple_slot = %Meeple_slot

#const MEEPLE_CURSOR = preload("res://objects/cursor/meeple_cursor.tscn")

var _lvl: int = -1
var _price: int = 0
var _min_lvl: int = -1

@export var allowed_types : Array[MM.TYPES] = []
@export var current_meeple: Meeple

func register_meeple(meeple: Meeple):
	pass

#func _ready():
	#meeple_slot = Meeple.new(1,self,MM.TYPES.INTERNAL)
	#if current_meeple: #!= null
		#var parent = current_meeple.get_parent()
		#current_meeple.reparent(meeple_slot,false)
		#meeple_slot.add_child(current_meeple)

func can_place_meeple(meeple: Meeple):
	return meeple.get_level() >= _min_lvl and meeple.get_type() in allowed_types

func place_meeple(meeple: Meeple) -> bool:
	if can_place_meeple(meeple):
		#current_figurine = meeple.instance() # - is it needed to create and instance? or just move the meeple in the structure
		#add_child(current_figurine) # - ADD TO SLOT
		return true
	return false
	
##var _active
#var _external: bool

# Called when the node enters the scene tree for the first time.
#func _ready():
	#lvl_label.text = "---"
	#price.text = "---"
	#req_lvl_label.text = ""
	#_external = false

#func set_requred_lvl_label_number(lvl_label_num: int) -> void:
	#_required_lvl_label = lvl_label_num
	#req_lvl_label.text = "%s" % [_required_lvl_label]
#
func setup(level: int) -> void:
	_lvl = level
	_price = GameManager.PRICES[level]
	#lvl_label.text = "%s" % [level]
	#price_label.text = "%s" % [level]

#func load_texture():
	#meeple.texture = Meeple_texture
	
#func get_price() -> int:
	#return _lvl_label_price
 
#### DRAG DATA
#func _get_drag_data(_at_position):
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#if meeple.texture == null:
		#return null
	#set_drag_preview(make_drag_preview())
	#return self
	 
### DROP DATA
func _can_drop_data(_pos, data) -> bool:
	return true
	#if data is Meeple:
		##if _required_lvl_label <= data._lvl_label_number:
		#print(data._lvl_label)
		#return true
		#
	#return false
	##typeof(data) == 
	##data is Texture2D
 #
func _drop_data(_pos, data):
	# Step 1: Save the global position of the node before reparenting
	var global_position = data.global_position
	
	# Step 2: Remove the node from its current parent
	if data.get_parent():
		data.get_parent().remove_child(data)
	
	data.set_position(Vector2.ZERO)
	# Step 3: Add the node to the new parent
	meeple_slot.add_child(data)
	
	## Step 4: Convert the saved global position to the new parent's local coordinates
	#data.position = meeple_slot.to_local(global_position)
	
	#data.reparent(meeple_slot,false)
	
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#print("droped")
	##meeple.modulate = data.modulate
	#var input_slot = data.slot
	#if input_slot != null:
		#input_slot.set_meeple(meeple)
	#meeple = data
	#data.slot = self
	
	#switch_data(data)
	
	#if meeple.texture == null: # no Meeple
		#update_data(data)
	#elif _lvl_label_number >= data._required_lvl_label:  # check if new swithced meeple will not have lower lvl_label as required
		#switch_data(data)
	#else:
		#print("Swith is not possible - you cannot downgrade lvl_label of meeple (on that spot)! >> play sound - wrong")
		#return
	#SignalManager.on_project_meeple_change.emit()
	
	#var temp = self.texture
	#texture = data.texture
	##if data != self:
	#data.texture = temp
	
#func empty_data():
	#meeple.texture = null
	#_lvl_label_number = -1
	#_lvl_label_price = 0
	#lvl_label.text = "---"
	#price.text = "---"
	#_external = false
	#
#func switch_data(new_data : Meeple):
	#var temp_lvl = _lvl
	#setup(new_data._lvl)
	#new_data.setup(temp_lvl)
#
#func update_data(new_data : Meeple):
	##load_texture()
	#setup(new_data._lvl)
	#
	#new_data.meeple.texture = null
	#unload_lvl_label_data(new_data)

func unload_lvl_label_data(data: Meeple):
	data._lvl_label_number = -1
	data._lvl_label_price = 0
	#label.text = "%sx%s" % [l_data.rows, l_data.cols]
	data.lvl_label.text = "---"
	data.price.text = "---"
#
	#
#func make_drag_preview() -> Control:
	#var preview_texture = TextureRect.new()
 #
	##preview_texture.texture = Meeple_drag_texture
	##preview_texture.expand_mode = 1
	##preview_texture.size = Vector2(130,130)
 #
	##var preview = Control.new()
	#var preview = MEEPLE_CURSOR.instantiate() 
	#preview.add_child(preview_texture)
	#preview.set_meeple_lvl_label(_lvl_label_number)
	##preview_texture.position = -0.5 * preview_texture.size
	#return preview
	
#func _on_pressed():
	#SoundManager.play_button_click(sound)
	#SignalManager.on_lvl_label_selected.emit(_lvl_label_number)

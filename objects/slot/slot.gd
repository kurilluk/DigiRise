@tool
class_name Slot extends Meeple

#@onready var sound = $Sound
#const MEEPLE = preload("res://objects/meeple/meeple.tscn")

# MEEPLE PROPERTIES
@onready var meeple_texture: TextureRect = %Meeple_texture
@onready var lvl_label: Label = %Level_value
@onready var price_label: Label = %Price_value

# SLOT PROPERTIES
#@onready var min_level_panel: PanelContainer = %Min_level
@onready var min_level_label: Label = %Min_level_value
@onready var allowed_color: ColorRect = %Allowed_color

@export var min_level: int = -1:
	set(value):
		min_level = value
		update_slot_visuals()

@export var allowed_type: MM.TYPES = MM.TYPES.EMPTY:
	set(value):
		allowed_type = value
		set_min_level_color()

#@export var allowed_types : Array[MM.TYPES] = []

#MEEPLE TOOL
func _ready():
	meeple_texture.texture = MEEPLE_TEXTURE
	#_color = MM.COLORS[type]
	#meeple_texture.modulate = _color
	#_price = MM.get_price(level)
	update_visuals()
	update_slot_visuals()
	set_min_level_color()

func update_visuals():
	#print("I AM IN SLOT FUNCTION!")
	if meeple_type == MM.TYPES.EMPTY or _is_locked:
		#price_label.visible = false
		self.mouse_default_cursor_shape = Control.CURSOR_ARROW
	else:
		#price_label.visible = true
		self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	_color = MM.COLORS[meeple_type]

	if meeple_texture:
		meeple_texture.modulate = _color
	update_text()

func update_text():
	if not lvl_label:
		return
	if meeple_type == MM.TYPES.EMPTY:
		lvl_label.text = ""
		price_label.text = ""
	else:
		if lvl_label:
			lvl_label.text = "%s" % [meeple_level]
		_price = MM.get_price(meeple_level, meeple_type == MM.TYPES.EXTERNAL)
		if price_label:
			price_label.text = "%s" % [_price]

func update_slot_visuals():
	if min_level_label:
		if min_level >= 0:
			#min_level_label.visible = true
			min_level_label.text = str(min_level)
		else:
			min_level_label.text = ""
			#min_level_label.visible = false


func is_empty():
	return true if meeple_type == MM.TYPES.EMPTY else false

func set_min_level_color():
	if allowed_color:
		#var style_box = min_level_panel.get_theme_stylebox("panel")
		#print("Try to change allowed_color - " + str(allowed_type))
		allowed_color.color = MM.COLORS[allowed_type]
#func _ready() -> void:
	#var new_meeple = MEEPLE.instantiate()
	#current_meeple = new_meeple
	#meeple_slot.add_child(new_meeple)
	#pass

#func _ready():
	#meeple_slot = Meeple.new(1,self,MM.TYPES.INTERNAL)
	#if current_meeple: #!= null
		#var parent = current_meeple.get_parent()
		#current_meeple.reparent(meeple_slot,false)
		#meeple_slot.add_child(current_meeple)

#func place_meeple(meeple: Meeple) -> bool:
	#if can_place_meeple(meeple):
		##current_figurine = meeple.instance() # - is it needed to create and instance? or just move the meeple in the structure
		##add_child(current_figurine) # - ADD TO SLOT
		#return true
	#return false
	

#func set_requred_lvl_label_number(lvl_label_num: int) -> void:
	#_required_lvl_label = lvl_label_num
	#req_lvl_label.text = "%s" % [_required_lvl_label]
#
#func setup(level: int) -> void:
	#level = level
	#_price = GameManager.PRICES[level]
	##lvl_label.text = "%s" % [level]
	##price_label.text = "%s" % [level]

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
	return can_place_meeple(data)

func can_place_meeple(meeple: Meeple):
	#print(str(meeple.get_level()) + " meeple level vs slot level " + str(min_level))
	return self.get_meeple_type() == MM.TYPES.EMPTY and meeple.get_meeple_level() >= min_level and (allowed_type == MM.TYPES.FREE or meeple.get_meeple_type() == allowed_type) #in allowed_types

func _drop_data(_pos, data):
	var new_meeple := data as Meeple
	if not new_meeple:
		return
		
	SoundManager.play_drop_click(meeple_sound)
	self.meeple_type = new_meeple.get_meeple_type()
	self.meeple_level = new_meeple.get_meeple_level() 
	#new_meeple.meeple_type = MM.TYPES.EMPTY
	new_meeple.empty_slot()
	
	SignalManager.on_project_meeple_change.emit()

#func _drop_data(_pos, data):
	## Step 1: Save the global position of the node before reparenting
	#var global_position = data.global_position
	#
	## Step 2: Remove the node from its current parent
	#if data.get_parent():
		#data.get_parent().remove_child(data)
	#
	#data.set_position(Vector2.ZERO)
	## Step 3: Add the node to the new parent
	#meeple_slot.add_child(data)
	#
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

func empty_slot():
	meeple_type = MM.TYPES.EMPTY
	meeple_level = -1
	_price = 0

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

#func unload_lvl_label_data(data: Meeple):
	#data._lvl_label_number = -1
	#data._lvl_label_price = 0
	##label.text = "%sx%s" % [l_data.rows, l_data.cols]
	#data.lvl_label.text = "---"
	#data.price.text = "---"

#func _on_pressed():
	#SoundManager.play_button_click(sound)
	#SignalManager.on_lvl_label_selected.emit(_lvl_label_number)

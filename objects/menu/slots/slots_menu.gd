@tool
class_name SlotMenu extends Control

@onready var slots = %Slots
@onready var name_label: Label = %Name
const SLOT = preload("res://objects/slot/slot.tscn")

@export var NAME = "Name of the slots":
	set(value):
		NAME = value
		update_name()

@export var VISIBLE_NAME: bool = true:
	set(value):
		VISIBLE_NAME = value
		update_name()

@export var TYPE: MM.TYPES = MM.TYPES.EMPTY:
	set(value):
		TYPE = value
		update_name()
		clear_slots()
		setup_grid()

@export var EMPTY_SLOTS: bool = false:
	set(value):
		EMPTY_SLOTS = value
		clear_slots()
		setup_grid()

@export var MIN_LEVEL: bool = false:
	set(value):
		MIN_LEVEL = value
		clear_slots()
		setup_grid()

#@export var MEEPLE_TYPE: MM.TYPES = MM.TYPES.EMPTY:
	#set(value):
		#MEEPLE_TYPE = value
		#clear_slots()
		#setup_grid()
		
@export var MEEPLE_levels: Array[int] = [5,5,10,10]:
	set(value):
		MEEPLE_levels = value
		clear_slots()
		setup_grid()

# Called when the node enters the scene tree for the first time.
func _ready():
	update_name()	
	clear_slots()
	setup_grid()
	#SignalManager.on_new_step.connect(on_next_step)

func update_name():
	if name_label:
		name_label.text = NAME
		name_label.add_theme_color_override("font_color",MM.COLORS[TYPE])
		name_label.visible = VISIBLE_NAME

func generate_employees(levels:Array[int]) -> void:
	for meeple_level in levels:
		create_meeple(meeple_level)

func create_meeple(level_value: int) -> void:
	if slots:
		var new_slot = SLOT.instantiate()
		slots.add_child(new_slot)
		new_slot.allowed_type = TYPE
		new_slot.min_level = level_value if MIN_LEVEL else -1
		new_slot.meeple_type = TYPE if !EMPTY_SLOTS else MM.TYPES.EMPTY
		new_slot.meeple_level = level_value if !EMPTY_SLOTS else -1

func setup_grid() -> void:
	for meeple_level in MEEPLE_levels:
		create_meeple(meeple_level)

func calculate_expenses() -> int:
	if not slots :
		return -1
	var expanses = 0
	for slot in slots.get_children():
		if slot is Slot and slot.get_meeple_level() >= 0 and !slot.is_queued_for_deletion():
			expanses += slot.get_meeple_price()
	return expanses

func clear_slots():
	if slots:
		for slot in slots.get_children():
			slot.queue_free()

func empty_slots():
	if slots:
		for slot : Slot in slots.get_children():
			slot.empty_slot()

func set_locked(value : bool):
	if slots:
		for slot : Slot in slots.get_children():
			slot._is_locked = value

func upskill_slots(trainer_level: int):
	if slots:
		for slot : Slot in slots.get_children():
			var meeple_level = slot.get_meeple_level()
			if meeple_level < trainer_level: # TODO more sofisticated calculation
				slot.set_meeple_upskill(1)
			
func is_full() -> bool:
	var m_count = 0
	for slot in slots.get_children():
		if slot is Slot and !slot.is_empty():
			m_count += 1
	#print("Req:%s / Ins:%s" % [slots.get_child_count(), m_count])
	return slots.get_child_count() == m_count

func get_prices_sum() -> int:
	var value = 0
	for slot in slots.get_children():
		if slot is Slot and !slot.is_queued_for_deletion(): # TODO is active? avoid empty, also external
			var price = slot.get_meeple_price()
			if price > 0:
				value += price
	return value
#func on_next_step():
	#pass

func get_employees() -> Array[int]:
	var list: Array[int]
	for slot in slots.get_children():
		if slot is Slot and slot.get_meeple_type() != MM.TYPES.EXTERNAL and not slot.is_queued_for_deletion():
			var level = slot.get_meeple_level()
			var upskill = slot.get_meeple_upskill()
			if slot.is_eployee() and level >= 0: # double check if is not external?
				list.append(level + upskill)
				slot.reset_meeple_upskill()
	return list

func clear_employees():
	for slot in slots.get_children():
		slot.queue_free()

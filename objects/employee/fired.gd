extends Control

@onready var slots = %Slots
#const MEEPLE = preload("res://objects/employee/employee.tscn")
const SLOT = preload("res://objects/slot/slot.tscn")

var MEEPLE_levels: Array[int] = [-1,-1,-1]

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_slots()
	setup_grid()
	#SignalManager.on_new_step.connect(on_next_step)

func create_meeple(level_value: int) -> void:
	var new_slot = SLOT.instantiate()
	slots.add_child(new_slot)
	new_slot.allowed_type = MM.TYPES.INTERNAL
	
	new_slot.meeple_type = MM.TYPES.EMPTY
	#new_slot.set_meeple_level(level_value)
	#new_slot.meeple_level = level_value


	#new_slot.load_texture()
	#new_slot._external = true

func setup_grid() -> void:
	for meeple_level in MEEPLE_levels:
		create_meeple(meeple_level)

func calculate_expenses() -> int:
	var expanses = 0
	for slot in slots.get_children():
		if slot is Slot:
			expanses += slot._level_price
	return expanses

func clear_slots():
	for slot in slots.get_children():
		slot.queue_free()

func fire_employees():
	for slot in slots.get_children():
		slot.empty_data()
		
#func on_next_step():
	#pass

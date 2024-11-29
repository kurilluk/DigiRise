class_name Training extends Control

@onready var background = %HeadBackground
# different activator
@onready var slot_menu: SlotMenu = %Trainer
# new aplicator
@onready var students: SlotMenu = %Students

#@onready var price = %Fee_value
@onready var income_value: Label = %Expenses_value
#@onready var expenses_value: Label = %Expenses_value

var _is_done : bool
var _is_activated: bool
var _price: int
var _income: int
var _trainer_level: int

func _ready():
	reset_menu()
	students.TYPE = MM.TYPES.INTERNAL
	SignalManager.on_project_meeple_change.connect(check_project_status)	

func reset_menu():
	_is_activated = false
	_is_done = false
	students.clear_slots()
	students.TYPE = MM.TYPES.INTERNAL
	slot_menu.empty_slots()
	slot_menu.set_locked(false)
	#slot_menu.TYPE = MM.TYPES.EXTERNAL

func check_project_status():
	_is_done = slot_menu.is_full()
	#print(_is_done)
	# new function to change status
	activate()
	upskill_students()
	update_expanses()
	#update_income()
	#change_color()
	SignalManager.on_project_change.emit()

func activate():
	if _is_done:# and not _is_activated:
		#students.TYPE = MM.TYPES.INTERNAL
		#slot_menu.set_locked(true)
		_trainer_level = slot_menu.slots.get_child(0).get_meeple_level() #.MEEPLE_levels[0]
		#_is_activated = true

func upskill_students():
	if _is_done: #_is_activated and 
		students.upskill_slots(_trainer_level)
	else:
		students.upskill_slots(0)

func update_expanses():
	var expanses = slot_menu.get_prices_sum()
	expanses += students.get_prices_sum()
	if expanses > 0:
		_income = - expanses
		income_value.text = str(_income)
	else:
		_income = 0
		income_value.text = "---"

func get_expanses() -> int:
	return _income
	
### SPECIFIC FOR PROJECTS
#func update_income():
	#var expanses = slot_menu.get_prices_sum() #calculate_real_expanses()
	##print(expanses)
	#if _is_done:
		#_income = _price - expanses
		#income_value.text = str(_income)
	#elif expanses > 0:
		#_income = - expanses
		#income_value.text = str(_income)
	#else:
		#_income = 0
		#income_value.text = "---"

### SPECIFIC TO PROJECTS
#func change_color(): 
	#if _income < 0 and _is_done:
		#background.color = MM.COLORS[MM.STATUS.LOSS] #Color("966711") # negative - red/orange
	#elif _income >= 0 and _is_done:
		#background.color = MM.COLORS[MM.STATUS.PROFIT] #Color("2a7d4b")  # positive - green or 966711
	#else:
		#background.color = MM.COLORS[MM.STATUS.NEUTRAL] #Color("4d4d4d") # neutral gray color

### SPECIFIC TO PROJECTS
#func set_requirements(req_levels: Array[int]):
	#slot_menu.MEEPLE_levels = req_levels
	##generate_slots(req_levels)
	#set_project_price(calculate_project_price(req_levels))

#func generate_slots(req_levels: Array[int]):
	#for req_level in req_levels:
		#add_req_employee(req_level)
#
#func add_req_employee(req_level: int):
	#var new_meeple = MEEPLE.instantiate()
	#slots.add_child(new_meeple)
	#new_meeple.set_requred_level_number(req_level)

### SPECIFIC TO PROJECTS
#func calculate_project_price(req_levels: Array[int]) -> int:
	#var expected_expanses = calculate_expected_expanses(req_levels)
	#var value = expected_expanses * GameManager.PROFIT # TODO experiment with the value or make it dynamic based on game steps
	#return value
	#
#func calculate_expected_expanses(req_levels: Array[int]) -> int:
	#var value = 0
	#for req_level in req_levels:
		#value += GameManager.PRICES[req_level]
	#return value
	
#func calculate_real_expanses() -> int:
	#var value = 0
	#for slot in slots.get_children():
		#if slot is Slot and !slot.is_queued_for_deletion(): # TODO is active? avoid empty, also external
			#var price = slot.get_price()
			#if price > 0:
				#value += price
	#return value

### slot changed to students - overriden
func get_employees() -> Array[int]:
	#students.upskill_slots(10) # TODO get slot/trainer level
	return students.get_employees()
	#var list: Array[int]
	#for slot in slots.get_children():
		#if slot is Slot and slot.get_meeple_type() != MM.TYPES.EXTERNAL and not slot.is_queued_for_deletion():
			#var level = slot.get_meeple_level()
			#if slot.is_eployee() and level >= 0: # double check if is not external?
				#list.append(level)
	#return list

# SPECIFIC TO PROJECTS
#func set_project_price(value: int):
	#_price = value
	#price.text = "%s" % value
	#


#func setup_grid() -> void:
	#for meeple_level in _requirements_levels:
		#create_requirements_space(meeple_level)

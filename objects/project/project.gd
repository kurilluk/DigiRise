class_name Project extends Control

@onready var background = %BG_Color
@onready var slots = %Requirements
@onready var price = %Fee_value
@onready var income_value = %Income_value

#const MEEPLE = preload("res://objects/employee/employee.tscn")

var _is_done : bool
var _price: int
var _income: int


func _ready():
	_is_done = false
	SignalManager.on_project_meeple_change.connect(check_project_status)

func check_project_status():
	_is_done = slots.is_full()
	update_income()
	change_color()
	SignalManager.on_project_change.emit()

func update_income():
	var expanses = slots.get_prices_sum() #calculate_real_expanses()
	#print(expanses)
	if _is_done:
		_income = _price - expanses
		income_value.text = str(_income)
	elif expanses > 0:
		_income = - expanses
		income_value.text = str(_income)
	else:
		_income = 0
		income_value.text = "---"

func change_color():  #TODO add colors to manager!
	if _income < 0 and _is_done:
		background.color = Color("966711") # negative - red/orange
	elif _income > 0 and _is_done:
		background.color = Color("2a7d4b")  # positive - green or 966711
	else:
		background.color = Color("4d4d4d") # neutral gray color

func set_requirements(req_levels: Array[int]):
	slots.MEEPLE_levels = req_levels
	#generate_slots(req_levels)
	set_project_price(calculate_project_price(req_levels))

#func generate_slots(req_levels: Array[int]):
	#for req_level in req_levels:
		#add_req_employee(req_level)
#
#func add_req_employee(req_level: int):
	#var new_meeple = MEEPLE.instantiate()
	#slots.add_child(new_meeple)
	#new_meeple.set_requred_level_number(req_level)

func calculate_project_price(req_levels: Array[int]) -> int:
	var expected_expanses = calculate_expected_expanses(req_levels)
	var value = expected_expanses * GameManager.PROFIT # TODO experiment with the value or make it dynamic based on game steps
	return value

func calculate_expected_expanses(req_levels: Array[int]) -> int:
	var value = 0
	for req_level in req_levels:
		value += GameManager.PRICES[req_level]
	return value
	
#func calculate_real_expanses() -> int:
	#var value = 0
	#for slot in slots.get_children():
		#if slot is Slot and !slot.is_queued_for_deletion(): # TODO is active? avoid empty, also external
			#var price = slot.get_price()
			#if price > 0:
				#value += price
	#return value
	
func get_employees() -> Array[int]:
	var list: Array[int]
	for slot in slots.get_children():
		if slot is Slot and !slot.is_queued_for_deletion(): # TODO is not external
			var level = slot.get_level()
			if slot.is_eployee() and level >= 0:
				list.append(level)
	return list
	
func set_project_price(value: int):
	_price = value
	price.text = "%s" % value
	


#func setup_grid() -> void:
	#for meeple_level in _requirements_levels:
		#create_requirements_space(meeple_level)

class_name Project
extends Control

@onready var background = %BG_Color
@onready var req_employees = %Requirements
@onready var price = %Fee_value
@onready var income_value = %Income_value

const MEEPLE = preload("res://objects/employee/employee.tscn")

var _is_done : bool
var _price: int
var _income: int

# status1 - no_req_meet, reg_meet
# status2 - running (unable to change inserted meeples), done - score and remove project from the offer

#var _requirements_levels: Array[int] = [2,1,1,1]

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_project_meeple_change.connect(check_project_status)
	#setup_grid()
	_is_done = false

func check_project_status():
	var m_count = 0
	for employee in req_employees.get_children():
		if employee is Employee and employee.meeple.texture != null:
			m_count += 1
			
	print("Req:%s / Ins:%s" % [req_employees.get_child_count(), m_count])
	if req_employees.get_child_count() == m_count:
		print("The project meets the requirements and can be executed/implemented/realized.")
		background.color = Color("2a7d4b")
		_is_done = true
	else :
		background.color = Color("4d4d4d")
		_is_done = false
	update_income()
	SignalManager.on_project_change.emit()

func update_income():
	var expanses = calculate_real_expanses()
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

func set_requirements(req_levels: Array[int]):
	generate_req_employees(req_levels)
	set_project_price(calculate_project_price(req_levels))

func generate_req_employees(req_levels: Array[int]):
	for req_level in req_levels:
		add_req_employee(req_level)

func add_req_employee(req_level: int):
	var new_meeple = MEEPLE.instantiate()
	req_employees.add_child(new_meeple)
	new_meeple.set_requred_level_number(req_level)

func calculate_project_price(req_levels: Array[int]) -> int:
	var expected_expanses = calculate_expected_expanses(req_levels)
	var value = expected_expanses * GameManager.PROFIT # TODO experiment with the value or make it dynamic based on game steps
	return value

func calculate_expected_expanses(req_levels: Array[int]) -> int:
	var value = 0
	for req_level in req_levels:
		value += GameManager.PRICES[req_level]
	return value
	
func calculate_real_expanses() -> int:
	var value = 0
	for req_emp in req_employees.get_children():
		if req_emp is Employee && !req_emp.is_queued_for_deletion(): # TODO is active? avoid empty, also external
			var price = req_emp.get_price()
			if price > 0:
				value += price
	return value
	
func get_employees() -> Array[int]:
	var list: Array[int]
	for emp in req_employees.get_children():
		if emp is Employee && !emp.is_queued_for_deletion(): # TODO is not external
			var level = emp._level_number
			if !emp._external && level >= 0:
				list.append(level)
	return list
	
func set_project_price(value: int):
	_price = value
	price.text = "%s" % value
	


#func setup_grid() -> void:
	#for meeple_level in _requirements_levels:
		#create_requirements_space(meeple_level)

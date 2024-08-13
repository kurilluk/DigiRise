class_name Project
extends Control

@onready var background = %BG_Color
@onready var req_employees = %Requirements
@onready var price = %Price

const MEEPLE = preload("res://objects/employee/employee.tscn")

var _is_done : bool
var _price: int

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
		background.color = Color("222222")
		_is_done = false

func set_requirements(req_levels: Array[int]):
	var value = 0
	for req_level in req_levels:
		create_req_employee(req_level)
		value += GameManager.PRICES[req_level]
	_price = value * get_profit()
	price.text = str(_price)
	
#TODO: increase base on steps?
func get_profit() -> float:
	return GameManager.PROFIT

func create_req_employee(req_level: int):
	var new_meeple = MEEPLE.instantiate()
	req_employees.add_child(new_meeple)
	new_meeple.set_requred_level_number(req_level)


#func setup_grid() -> void:
	#for meeple_level in _requirements_levels:
		#create_requirements_space(meeple_level)

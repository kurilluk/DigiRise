extends PanelContainer

@onready var employees = %Employees
@onready var expenses_value = %Expenses_value
const MEEPLE = preload("res://objects/employee/employee.tscn")

var EMPLOYEES_levels: Array[int] = [0,0,1,1,2,3,4,5,8,10]

var _expanses: int

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_new_step.connect(on_next_step)
	SignalManager.on_project_meeple_change.connect(check_status)
	_expanses = 0
	initialze_employees()


func create_employee_meeple(ln: int) -> void:
	var new_meeple = MEEPLE.instantiate()
	employees.add_child(new_meeple)
	new_meeple.set_level_number(ln)
	new_meeple.load_texture()

func initialze_employees() -> void:
	for meeple_level in EMPLOYEES_levels:
		create_employee_meeple(meeple_level)
	update_expanses()

func calculate_expenses() -> int:
	var expanses = 0
	for emp in employees.get_children():
		if emp is Employee:
			expanses += emp._level_price
	return expanses

func update_expanses():
	_expanses = calculate_expenses()
	expenses_value.text = str(-_expanses)
	
func get_expanses() -> int:
	return _expanses

func clear_intern():
	for emp in employees.get_children():
		emp.queue_free()

func check_status():
	update_expanses()

func on_next_step():
	pass
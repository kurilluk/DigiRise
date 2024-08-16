extends PanelContainer

@onready var employees = %Employees
const MEEPLE = preload("res://objects/employee/employee.tscn")

var EMPLOYEES_levels: Array[int] = [5,5,10,10]

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_grid()
	SignalManager.on_new_step.connect(on_next_step)

func create_employee_meeple(ln: int) -> void:
	var new_meeple = MEEPLE.instantiate()
	employees.add_child(new_meeple)
	new_meeple.set_level_number(ln)
	new_meeple.load_texture()

func setup_grid() -> void:
	for meeple_level in EMPLOYEES_levels:
		create_employee_meeple(meeple_level)

func calculate_expenses() -> int:
	var expanses = 0
	for emp in employees.get_children():
		if emp is Employee:
			expanses += emp._level_price
	return expanses

func clear_intern():
	for emp in employees.get_children():
		emp.queue_free()

func on_next_step():
	pass

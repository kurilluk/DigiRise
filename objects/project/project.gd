class_name Project
extends Control

@onready var req_employees = %Requirements
const MEEPLE = preload("res://objects/employee/employee.tscn")

# status1 - no_req_meet, reg_meet
# status2 - running (unable to change inserted meeples), done - score and remove project from the offer

#var _requirements_levels: Array[int] = [2,1,1,1]

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_project_meeple_change.connect(check_project_status)
	#setup_grid()

func check_project_status():
	var m_count = 0
	for employee in req_employees.get_children():
		if employee is Employee and employee.meeple.texture != null:
			m_count = m_count + 1
			
	print("Req:%s / Ins:%s" % [req_employees.get_child_count(), m_count])
	if req_employees.get_child_count() == m_count:
		print("The project meets the requirements and can be executed/implemented/realized.")

func set_requirements(req_levels):
	for req_level in req_levels:
		create_req_employee(req_level)
	pass

func create_req_employee(req_level: int):
	var new_meeple = MEEPLE.instantiate()
	req_employees.add_child(new_meeple)
	new_meeple.set_requred_level_number(req_level)


#func setup_grid() -> void:
	#for meeple_level in _requirements_levels:
		#create_requirements_space(meeple_level)

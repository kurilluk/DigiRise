class_name Market
extends Control

const PROJECT = preload("res://objects/project/project.tscn")

@onready var projects: Market = $"."

const MAX_LEVEL = 10

const PROJECT_TYPES = [
	[2,1,0],
	[2,0],
	[2,1],
	[2,2,0],
	[3,1],
	[2,1,1,0]
]

var _projects_count = 4
var _phase = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	projects.columns = 2
	clear_projects_on_market()
	generate_projects(_projects_count,_phase)
	SignalManager.on_new_step.connect(on_next_step)

func create_new_project(phase: int) -> void:
	var new_project = PROJECT.instantiate()
	projects.add_child(new_project)
	#var req: Array[int] = [2,1,1,1,0]
	var req = PROJECT_TYPES[randi() % PROJECT_TYPES.size()]
	new_project.set_requirements(increase_project_reg(req,phase))

func increase_project_reg(requirements, phase) -> Array[int]:
	var results: Array[int] = []
	for req in requirements:
		results.append(get_increased_level(req,phase))
	results.sort()
	results.reverse()
	return results
	
func get_increased_level(level: int, round: int) -> int:
	var new_level = level + (randi() % (MAX_LEVEL - level)) * (round - 1) / MAX_LEVEL
	if new_level > MAX_LEVEL:
		new_level = MAX_LEVEL
	return new_level

func generate_projects(count: int, phase: int) -> void:
	for project in range(count):
		create_new_project(phase)
#
#func generate_project_requirements():
	#pass

func clear_projects_on_market():
	for project in projects.get_children():
		project.queue_free()

func on_next_step():
	#clear_projects_on_market()
	#_phase = _phase + 1
	#generate_projects(_projects_count, _phase)
	pass
	
func calculate_income() -> int:
	if not projects:
		return -1
	var income = 0
	for project in projects.get_children():
		if project is Project and not project.is_queued_for_deletion():
			income += project._income
			#if project._is_done:
				#income += project._price
	#print("Income is " + income)
	return income
	
func get_employees() -> Array[int]:
	var list: Array[int]
	for project in projects.get_children():
		if project is Project:
			list.append_array(project.get_employees())
	return list

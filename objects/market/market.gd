class_name Market
extends Control

const PROJECT = preload("res://objects/project/project.tscn")
@onready var offers = %Offers

# Called when the node enters the scene tree for the first time.
func _ready():
	offers.columns = 2
	generate_projects(4,1)

func create_new_project(ln: int) -> void:
	var new_project = PROJECT.instantiate()
	offers.add_child(new_project)
	var req: Array[int] = [2,1,1,1,0]
	new_project.set_requirements(req)

func generate_projects(count: int, phase: int) -> void:
	for project in range(count):
		create_new_project(project)

func generate_project_requirements():
	pass

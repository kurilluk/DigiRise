extends PanelContainer

@onready var em_container = $Employees
const MEEPLE = preload("res://objects/employee/employee.tscn")

var EMPLOYEES_levels: Array[int] = [0,0,1,1,2,2,2,3,4,5,8,10]

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_grid()
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func create_employee_meeple(ln: int) -> void:
	var new_meeple = MEEPLE.instantiate()
	em_container.add_child(new_meeple)
	new_meeple.set_level_number(ln)
	new_meeple.load_texture()

func setup_grid() -> void:
	for meeple_level in EMPLOYEES_levels:
		create_employee_meeple(meeple_level)

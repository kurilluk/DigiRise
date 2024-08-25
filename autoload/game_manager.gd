extends Node


const PROFIT: float = 1.5
const PRICES: Array[int] = [
	100,
	120,
	140,
	160,
	180,
	200,
	220,
	240,
	260,
	280,
	300
]

# GLOBAL STEP
var _step: int = 0
var STEP: int:
	get:
		return _step
		
func reset_step_counter():
	_step = 0
	
func next_step():
	_step += 1


# hack for missing event when misslead drop happen
func _input(event):
	#print("lisen events")
	if event is InputEventMouseButton:
		#print("mouse event")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

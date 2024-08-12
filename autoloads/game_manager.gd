extends Node

#const PRICES_D: Dictionary = {
	#1: { "level": 1, "price": 1000 },
	#2: { "level": 2, "cols": 1200 },
	#3: { "rows": 3, "cols": 1400 },
	#4: { "rows": 5, "cols": 5 },
	#5: { "rows": 5, "cols": 7 }
	#}
	#
#const EMPLOYEES: Array[int] = []

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


func _input(event):
	#print("lisen events")
	if event is InputEventMouseButton:
		#print("mouse event")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

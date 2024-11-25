extends Control

@onready var rounds_value: Label = %Rounds_value

var _actual_round : int

func _ready():
	reset_round_counter()

func reset_round_counter():
	_actual_round = 0
	set_next_round()

func set_next_round() -> bool:
	_actual_round += 1
	if _actual_round > MM.ROUNDS:
		return true
	else:
		rounds_value.text = "%s / %s" % [_actual_round,MM.ROUNDS]
		return false

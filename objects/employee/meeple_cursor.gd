extends Control

@onready var meeple_level = %MeepleLevel

func set_meeple_level(level: int):
	%MeepleLevel.text = str(level)

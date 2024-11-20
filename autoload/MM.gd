@tool
extends Node

enum TYPES {
	FREE = -2,
	EMPTY = -1,
	INTERNAL = 0,
	EXTERNAL = 1,
	NEW = 2
}

const COLORS = {
	TYPES.FREE : Color("2e2e2e"), #dark grey?
	TYPES.EMPTY : Color("404040"), #grey - Color("4d4d4d")
	TYPES.INTERNAL : Color("967e11"),
	TYPES.EXTERNAL : Color("478CBF"),#Color("117796"),
	TYPES.NEW: Color("40ba40") #green done - Color("2a7d4b")
}

const _price_factor: int = 20
const _external_multiplier: int = 2
const _basic_price: int = 100

func get_price(level:int, external: bool = false)-> int: #TODO type of employee/meeple
	#var facor = external ? _external_multiplier * _price_factor : _price_factor
	return _basic_price + _price_factor * level

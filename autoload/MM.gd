@tool
extends Node

enum TYPES {
	FREE = -2,
	EMPTY = -1,
	INTERNAL = 0,
	EXTERNAL = 1,
	NEW = 2
}

enum STATUS{
	PROFIT = 10,
	LOSS = 11,
	NEUTRAL = 12
}

const COLORS = {
	TYPES.FREE : Color("2e2e2e"), #dark grey?
	TYPES.EMPTY : Color("404040"), #grey - Color("4d4d4d"), 4B585C, 404040
	TYPES.INTERNAL : Color("3496B7"), #Color("B3732E"), #967e11, 978111, B8872E, #FFDC9C, 8F6924, 5CA8F5, B8A12E
	TYPES.EXTERNAL : Color("B3952E"),#Color("117796"), 478CBF
	TYPES.NEW: Color("266787"), #Color("835422"), #green done - Color("2a7d4b"), ABBF0F, 40ba40, ABBF0F, 666D3B, B8A12E, A6D4FF, 8F6924
	STATUS.PROFIT: Color("11965D"),
	STATUS.LOSS: Color("B35C2E"), #8F5624, B35C2E, B3442E
	STATUS.NEUTRAL: Color("4d4d4d")
}

const _price_factor: int = 20
const _external_multiplier: int = 2
const _basic_price: int = 100

func get_price(level:int, external: bool = false)-> int: #TODO type of employee/meeple
	#var facor = external ? _external_multiplier * _price_factor : _price_factor
	return _basic_price + _price_factor * level

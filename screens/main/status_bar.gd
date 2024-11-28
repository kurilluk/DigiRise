extends Control

@onready var internal = %Internal
@onready var market = %Market
@onready var money = %Money_value
@onready var profit_loss = %"Profit-Loss_value"
@onready var profit_loss_background: ColorRect = %Background
@onready var training = %Training
@onready var hiring: Hiring = %Hiring
@onready var end_screen: Control = %EndScreen
@onready var fired_value: Label = %Fired_value

var _money : int
var _profit_loss: int 
var _fired_employees: Array[int]

func _ready():
	SignalManager.on_project_change.connect(update_profit_loss)
	set_initial_money()
	reset_fired_employees()
	update_profit_loss()

func update_profit_loss():
	# income from projects
	var income = market.calculate_income()
	# expanses from unutilized emp
	var expanses = internal.calculate_expenses()
	expanses -= training.get_expanses()
	expanses -= hiring.get_expanses()
	fired_value.text = str(get_fired_emploees_number())

	_profit_loss = income - expanses
	set_profit_loss_value(_profit_loss)

func reset_fired_employees():
	_fired_employees = []

func get_fired_emploees_number() -> int:
	return _fired_employees.size()

func add_fired_employees(list : Array[int]):
	_fired_employees.append_array(list)

func set_profit_loss_value(value : int):
	profit_loss.text = str(value)
	if value < 0 :
		profit_loss_background.color = MM.COLORS[MM.STATUS.LOSS] #Color("966711") # negative - red/orange
	else :
		profit_loss_background.color = MM.COLORS[MM.STATUS.PROFIT] #Color("2a7d4b")  # positive - green or 966711
		
func set_initial_money():
	_money = MM.INITIAL_MONEY
	money.text = str(_money)

func score_round() -> int:
	_money += _profit_loss
	money.text = str(_money)
	_profit_loss = 0
	profit_loss.text = str(_profit_loss)
	return _money

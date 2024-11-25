extends Control

@onready var internal = %Internal
@onready var market = %Market
@onready var money = %Money_value
@onready var profit_loss = %"Profit-Loss_value"
@onready var profit_loss_background: ColorRect = %Background
@onready var training: Training = %Training

var _money : int
var _profit_loss: int 

func _ready():
	SignalManager.on_project_change.connect(update_profit_loss)
	set_initial_money()
	update_profit_loss()

func update_profit_loss():
	# income from projects
	var income = market.calculate_income()
	# expanses from unutilized emp
	var expanses = internal.calculate_expenses()
	expanses -= training.get_expanses()

	_profit_loss = income - expanses
	set_profit_loss_value(_profit_loss)
	
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

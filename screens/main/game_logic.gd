extends Control

var _capital : int
var capital: int:
	get:
		return _capital
		
func income(value: int ):
	_capital += value
	
func expenses(value : int):
	_capital -= value

@onready var internal = %Internal
@onready var market = %Market
@onready var money = %Money
@onready var steps = %Steps
@onready var profit_loss = %Profit_Loss

@onready var fire_only = %Fire_only
@onready var hire = %Hire
@onready var external = %External

const  MAX_STEPS: int = 15
var _step: int

var _project_fees
var _expenses
var _profit_loss: int 

func _ready():
	SignalManager.on_project_meeple_change.connect(check_status)
	_capital = 1500
	_step = 1
	update_capital()
	update_steps()
	update_profit_loss()

func check_status():
	update_profit_loss()

func update_steps():
	steps.text = "STEP\n%s / %s" % [_step,MAX_STEPS]

#func calculate_expenses():
	#var expanses = internal.calculate_expenses()
	#_capital -= expanses
	#update_capital()
	#
#func calculate_income():
	#var income = market.calculate_income()
	#_capital += income
	#update_capital()

func update_capital():
	money.text = "MONEY\n%s" % _capital
	
#TODO - extern, experts...???
#TODO - Hire - fire separate
#TODO - education on left panel

func update_profit_loss():
	# income from projects
	var income = market.calculate_income()
	# expanses from unutilized emp
	var expanses = internal.calculate_expenses()
	# expanses from education
	#TODO education expanses
	_profit_loss = income - expanses
	profit_loss.text = "PROFIT/LOSS\n%s" % _profit_loss

func _on_next_phase_button_pressed():
	
	# update levelu
	if _step != MAX_STEPS:
		_step += 1
		update_steps()
	else:
		#TODO you win - your capital is
		return
	
	# 1st phase: capital -> income/expanses
		# vypocitaj naklad z nealokovanych zamestnancov (a pridaj ich do noveho zoznamu)
		# vypocitaj naklad z education
		# vyhodnot kazdy projekt - income/expanses (moznost simulacie cash-flow)
		# GROSS MARGIN - EDUCATION / NEVYUZITY POTENCIAL-INTERNAL = PROFIT/LOSS sumarization
	_capital += _profit_loss
	update_capital()
	
	# 2nd phase: upskill -> project, education, and create intern emp. list 
		# zapamataj si emp. na projekte - skillni ich podla pravidiel
		# uloz upskilled emp. do noveho array internal emp.
		# ak je v liste externy emp. neukladaj ho!
		# vyhodnot... education podobnym sposobom
		# remove/free hire/fire emp.

	# 3rd phase: clear and prepace new intern emp., level up new projects
		# free projects and create new up leveled projects
		# vytvor novy zoznam intern - pridaj do neho nealokovanych zamestnancov, upskillovanych projektovych zam. a education

	# usporiadaj novy zoznam (reversed) a v novom kole z neho vytvor - ruku - novy internal emp. panel
	reset_board()

func reset_board():
	# build list of used employees
	# remove fired emp.
	fire_only.fire_employees()
	# reset hiring offer?
	hire.clear_intern()
	hire.setup_grid()
	# reset experts
	external.clear_intern()
	external.setup_grid()
	
	internal.clear_intern()
	internal.initialze_employees() #TODO list of used employees
	SignalManager.on_new_step.emit()
	update_profit_loss()

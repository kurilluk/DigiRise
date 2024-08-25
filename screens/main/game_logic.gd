extends Control

var _capital : int
var capital: int:
	get:
		return _capital
		
func income(value: int ):
	_capital += value
	
func expenses(value : int):
	_capital -= value
	
@onready var sound = $Sound

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
	SignalManager.on_project_change.connect(check_status)
	_capital = 1500
	_step = 1
	update_capital()
	update_steps()
	update_profit_loss()
	%EndScreen.visible = false

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
	expanses -= %Education._income
	# expanses from education
	#TODO education expanses
	_profit_loss = income - expanses
	profit_loss.text = "PROFIT/LOSS\n%s" % _profit_loss

func _on_next_phase_button_pressed():
	#SoundManager.play_sound(sound)
	# update levelu
	if _step != MAX_STEPS:
		_step += 1
		update_steps()
	else:
		#you win - your capital is
		_capital += _profit_loss
		%EndLabel.text = "You win:\nYour score is\n%s" % _capital
		%EndScreen.visible = true
		# TODO play the sound - victory!!!
		return
	
	SoundManager.play_next_click(sound)
	# 1st phase: capital -> income/expanses
		# vypocitaj naklad z nealokovanych zamestnancov (a pridaj ich do noveho zoznamu)
		# vypocitaj naklad z education
		# vyhodnot kazdy projekt - income/expanses (moznost simulacie cash-flow)
		# GROSS MARGIN - EDUCATION / NEVYUZITY POTENCIAL-INTERNAL = PROFIT/LOSS sumarization
	_capital += _profit_loss
	update_capital()
	
	if _capital < 0:
		%EndLabel.text = "Game Over:\nYour capital is negative.\nBetter luck next time!"
		%EndScreen.visible = true
		#print("THE END - zero capital!")
	
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
	var list_of_employees:Array[int]
	list_of_employees.append_array(market.get_employees())
	list_of_employees.append_array(internal.get_employees())
	list_of_employees.append_array(%Education.get_employees())
	list_of_employees.sort()
	#list_of_employees.reverse()

	# remove fired emp.
	fire_only.fire_employees()
	# reset hiring offer?
	hire.clear_intern()
	hire.setup_grid()
	# reset experts
	#external.clear_intern()
	#external.setup_grid()
	
	%Education.clear_students()
	%Education.update_income()
	
	internal.clear_employees()
	internal.generate_employees(list_of_employees) #TODO list of used employees
	#reset market offer
	SignalManager.on_new_step.emit()
	update_profit_loss()
	

### DROP DATA
func _can_drop_data(_pos, data):
	return true
 
func _drop_data(_pos, data):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SoundManager.play_drop_click(sound)
	#if meeple.texture == null: # no Meeple

var _nute_music = true
func _on_music_is_pressed():
	SoundManager.play_button_click(sound)
	AudioServer.set_bus_mute(2,_nute_music)
	_nute_music = !_nute_music

@onready var end_screen = %EndScreen

func _on_reset_pressed():
	#end_screen.hide()
	get_tree().reload_current_scene()
	#%EndScreen.visible = false


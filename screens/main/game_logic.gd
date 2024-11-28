extends Control

@onready var screen_sound = $Screen_sound
@onready var buttons_sound: AudioStreamPlayer = $Buttons_sound
@onready var ambient_loop: AudioStreamPlayer = $Ambient_loop
@onready var ambient_hit: AudioStreamPlayer = $Ambient_hit

@onready var status_bar: Control = %StatusBar
@onready var rounds_bar: Control = %RoundsBar

@onready var external = %Experts
@onready var hire = %Hire
@onready var internal = %Internal
@onready var fire_only = %Fire_only
@onready var market = %Market
@onready var training = %Training
@onready var hiring: Hiring = %Hiring
@onready var firing: = %Firing

func _ready():
	status_bar.set_initial_money()
	status_bar.update_profit_loss()
	rounds_bar.reset_round_counter()
	SignalManager.on_new_round_button_pressed.connect(_on_next_phase_button_pressed)
	SoundManager.play_initial_ambient_loop_only(ambient_loop)
	#SoundManager.play_ambient_hit(ambient_loop,ambient_hit)
	%EndScreen.visible = false

func _on_next_phase_button_pressed():
	# TODO - next round
	#-> disable next round button
	#-> score round / money + profit/loss - prepocitanie penazi (odpocet-pripocet po jednom), 
	#-> upskill meeples -> popup ulskilled value, HIDE midle_main_menu 
	#-> move meeples to init slots - remove old slots 1 by 1, add slots with meeple 1 by 1
	#-> start round 1+ (screen) 
	#-> show main_menu with projects
	#-> enable next round button
	upskill_meeples()
	score_round()
	reset_board()

func upskill_meeples():
	pass
	
func score_round():
	var money = status_bar.score_round()
	#SoundManager.play_next_click(buttons_sound)
	#SoundManager.play_ambient_hit(ambient_loop,ambient_hit)
		
	# update levelu
	var last_round_end = rounds_bar.set_next_round()
	if last_round_end: #_step != MM.ROUNDS:
		%EndLabel.text = "You win:\nYour score is\n%s" % money
		%EndScreen.visible = true
		SoundManager.play_sound(ambient_loop,SoundManager.SOUND_VICTORY)
		return
	
	if money < 0:
		%EndLabel.text = "Game Over:\nYour capital is negative.\nBetter luck next time!"
		%EndScreen.visible = true
		SoundManager.play_sound(ambient_loop,SoundManager.SOUND_DEFEAT)
		#print("THE END - zero capital!")
		return
	
	SoundManager.play_ambient_hit(ambient_loop,ambient_hit)
	
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
	#reset_board()

func reset_board():
	# build list of used employees
	var list_of_employees:Array[int]
	list_of_employees.append_array(market.get_employees())
	list_of_employees.append_array(internal.get_employees())
	list_of_employees.append_array(training.get_employees())
	list_of_employees.append_array(hiring.get_employees())
	#list_of_employees.append_array(%Education.get_employees())
	list_of_employees.sort()
	#list_of_employees.reverse()

	# remove fired emp.
	#fire_only.fire_employees()
	
	# reset hiring offer?
	#hire.clear_intern()
	#hire.setup_grid()
	
	# reset experts
	external.reset_slots()
	
	var fired_employees = firing.get_employees()
	status_bar.add_fired_employees(fired_employees)
	firing.reset_slots()
	
	training.reset_menu()
	training.update_expanses()
	
	hiring.reset_menu()
	hiring.update_expanses()
	
	internal.clear_employees()
	internal.generate_employees(list_of_employees) #TODO list of used employees
	#reset market offer
	SignalManager.on_new_step.emit()
	status_bar.update_profit_loss()
	

#### DROP DATA
#func _can_drop_data(_pos, data):
	#return true
 #
#func _drop_data(_pos, data):
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#SoundManager.play_drop_click(sound)
	##if meeple.texture == null: # no Meeple

var _nute_music = true
func _on_music_is_pressed():
	SoundManager.play_button_click(buttons_sound)
	AudioServer.set_bus_mute(2,_nute_music)
	_nute_music = !_nute_music

@onready var end_screen = %EndScreen

func _on_reset_pressed():
	#end_screen.hide()
	get_tree().reload_current_scene()
	#%EndScreen.visible = false


func _on_next_button_pressed() -> void:
	_on_next_phase_button_pressed()

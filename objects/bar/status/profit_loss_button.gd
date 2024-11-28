extends PanelContainer

var is_hovered = false

func _ready() -> void:
	#set_process_mouse_enter_exit(true)
	self.connect("mouse_exited", _on_mouse_exited)
	self.connect("mouse_entered", _on_mouse_entered)
	update_style(false)

func _on_mouse_entered():
	print("Hover")
	is_hovered = true
	update_style(true)

func _on_mouse_exited():
	print("Hover ends")
	is_hovered = false
	update_style(false)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_hovered:
			_on_button_click()

func _on_button_click():
	print("Button clicked!")
	SignalManager.on_new_round_button_pressed.emit()

func update_style(hovered: bool):
	if hovered:
		self.modulate = Color(1, 1, 1, 0.8) # Napr. zmena priehľadnosti
	else:
		self.modulate = Color(1, 1, 1, 1)  # Pôvodný vzhľad

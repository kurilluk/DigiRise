extends PanelContainer

@onready var fired: SlotMenu = %Fired

func reset_slots():
	fired.empty_slots()

func get_employees():
	return fired.get_employees()

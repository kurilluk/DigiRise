extends PanelContainer

@onready var fired: SlotMenu = %Fired

func reset_slots():
	fired.empty_slots()

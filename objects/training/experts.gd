extends PanelContainer

@onready var experts: SlotMenu = %Experts

func _ready() -> void:
	pass # Replace with function body.

func reset_slots():
	experts.clear_slots()
	experts.setup_grid()

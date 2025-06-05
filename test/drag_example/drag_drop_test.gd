extends Node2D

func _notification(what:int)->void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		# Drag data is available (populated by our _get_drag_data() function for example)
		var data = get_viewport().gui_get_drag_data()
		print("Drag mode")
		# Use the drag data
	if what == Node.NOTIFICATION_DRAG_END:
		# Drag data is no longer available and has been disposed already
		print("Drag ended. Success: ", get_viewport().gui_is_drag_successful())

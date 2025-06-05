extends PanelContainer

const C_INITIAL = Color(1,1,1,0.1)
const C_DRAG = Color(1,1,1,0.5)
const C_HOVER = Color(1,1,1,1.0)

@onready var drop_item: ColorRect = $DropItem
@onready var meeple_texture: TextureRect = $MeepleTexture

var drag_mode

func _ready() -> void:
	meeple_texture.modulate = C_INITIAL
	drag_mode = false
	
func _notification(what:int)->void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		# Drag data is available (populated by our _get_drag_data() function for example)
		var data = get_viewport().gui_get_drag_data()
		drag_mode = true
		var tween = get_tree().create_tween()
		tween.tween_property(meeple_texture, "modulate", C_DRAG, 0.25)
		# Use the drag data
	if what == Node.NOTIFICATION_DRAG_END:
		# Drag data is no longer available and has been disposed already
		#print("Drag ended. Success: ", get_viewport().gui_is_drag_successful())
		drag_mode = false
		meeple_texture.modulate = C_INITIAL

func _on_mouse_entered() -> void:
	print("ENTERED")
	if !drag_mode: return
	#self.transform.scaled()
	#size = Vector2(200,200)
	#scale = Vector2(1.2,1.2)
	drop_item.custom_minimum_size = Vector2(128,128)
	var tween = get_tree().create_tween()
	tween.tween_property(meeple_texture, "modulate", C_HOVER, 0.25) # Zmiznutie za 1 sekundu

func _on_mouse_exited() -> void:
	print("EXITED")
	if !drag_mode: return
	#scale = Vector2(1.0,1.0)
	drop_item.custom_minimum_size = Vector2(64,64)
	var tween = get_tree().create_tween()
	if drag_mode:
		tween.tween_property(meeple_texture, "modulate", C_DRAG, 0.25)
	else:
		tween.tween_property(meeple_texture, "modulate", C_INITIAL, 0.25)

### DROP DATA
func _can_drop_data(_pos, data) -> bool:
	print("Asking")
	return true

func _drop_data(_pos, data):
	var new_meeple := data as Meeple
	if not new_meeple:
		return
		
	#SFX.play(SFX.SOUND_DROP)
	##SoundManager.play_drop_click(meeple_sound)
	#self.meeple_type = new_meeple.get_meeple_type()
	#self.meeple_level = new_meeple.get_meeple_level()
	#self.set_meeple_upskill(0)
	##new_meeple.meeple_type = MM.TYPES.EMPTY
	#new_meeple.empty_slot()
	#new_meeple.set_meeple_upskill(0)
	#
	#SignalManager.on_project_meeple_change.emit()

#func _on_drop_item_mouse_entered() -> void:
	#print("ENTERED")
	##self.transform.scaled()
	##size = Vector2(200,200)
	##scale = Vector2(1.2,1.2)
	#drop_item.custom_minimum_size = Vector2(128,128)


#func _on_drop_item_mouse_exited() -> void:
	#print("EXITED")
	##scale = Vector2(1.0,1.0)
	#drop_item.custom_minimum_size = Vector2(64,64)

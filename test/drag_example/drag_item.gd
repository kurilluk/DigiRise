extends ColorRect

const MEEPLE_CURSOR =  preload("res://objects/cursor/meeple_cursor.tscn")

func _get_drag_data(at_position:Vector2)->Variant:
	#var item := inventory.item_at(at_position)
	#if item == null: return null

	#var drag_data = ItemDrag.new(self, item, _create_item_preview(item))
	#set_drag_preview(self)
	set_drag_preview(make_drag_preview())
	return self

func make_drag_preview() -> Control:
	var preview = MEEPLE_CURSOR.instantiate()
	#preview.setup(meeple_level,_color) #MM.COLORS[type]
	return preview
	

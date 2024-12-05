extends Control

const GAME = preload("res://screens/game/game.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#play_sound()
	#SFX.play(SFX.SOUND_VICTORY,-8.0)
	pass # Replace with function body.

func play_sound():
	#AudioManager.play_SFX(AudioManager.MUSIC.streams[AudioManager.MUSIC.STREAM.HIT])
	# MUSIC.play(MUSIC.LIB.HIT)
	SFX.play(SFX.SOUND_BUTTON)
	#SFX.play(SFX.SOUND_VICTORY,-8.0)
	BGM.play_next_phase()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_page_up"):
		play_sound()

	if Input.is_action_just_pressed("ui_page_down"):
		SFX.play(SFX.SOUND_BUTTON)
		BGM.stop()


func _on_button_pressed() -> void:
	SFX.play(SFX.SOUND_BUTTON)
	#BGM.play_next_phase()
	await create_tween().tween_property(self,"modulate:a", 0.0, 0.5).finished
	get_tree().change_scene_to_packed(GAME)

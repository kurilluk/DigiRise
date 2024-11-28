extends Node

const SOUND_MAIN_MENU = "main"
const SOUND_IN_GAME = "ingame"
const SOUND_SUCCESS = "success"
const SOUND_GAME_OVER = "gameover"
const SOUND_SELECT_TILE = "tile"
const SOUND_SELECT_BUTTON = "button"
const SOUND_SELECT_ERROR = "error"
const SOUND_DRAG = "drag"
const SOUND_DROP = "drop"
const SOUND_LOCK = "lock"
const SOUND_VICTORY = "win"
const SOUND_DEFEAT = "lose"
const SOUND_PROJECT_DONE = "done"

const SOUNDS = {
	#SOUND_MAIN_MENU: preload("res://assets/sounds/bgm_action_3.mp3"),
	#SOUND_IN_GAME: preload("res://assets/sounds/bgm_action_4.mp3"),
	#SOUND_SUCCESS: preload("res://assets/sounds/sfx_sounds_fanfare3.wav"),
	#SOUND_GAME_OVER: preload("res://assets/sounds/sfx_sounds_powerup12.wav"),
	SOUND_SELECT_TILE: preload("res://assets/sounds/Amajor9_HIT-separated.ogg"),
	SOUND_SELECT_BUTTON: preload("res://assets/sounds/BOX_Click_01.wav"),
	SOUND_DRAG: preload("res://assets/sounds/Wooden_Click_01.wav"),
	SOUND_DROP: preload("res://assets/sounds/Wooden_Click_02.wav"),
	#SOUND_LOCK: preload("res://assets/sounds/Locked_LATCH_01.ogg")
	SOUND_LOCK: preload("res://assets/sounds/Locked_by_keys_01.ogg"),
	SOUND_DEFEAT: preload("res://assets/sounds/Orchestral_Defeat_sound_02.mp3"),
	SOUND_VICTORY: preload("res://assets/sounds/Orchestral_Victory_sound_03_200BPM.mp3"),
	SOUND_PROJECT_DONE: preload("res://assets/sounds/Cmajor9_HIT_separated.ogg")
	#SOUND_SELECT_ERROR: preload("res://assets/sounds/error_008.ogg")
}

func play_sound(player: AudioStreamPlayer, key: String) -> void:
	if SOUNDS.has(key) == false:
		return
	
	player.stop()
	player.stream = SOUNDS[key]
	player.play()
	
func play_drag_click(player: AudioStreamPlayer) -> void:
	play_sound(player,SOUND_DRAG)

func play_drop_click(player: AudioStreamPlayer) -> void:
	play_sound(player,SOUND_DROP)
	
func play_button_click(player: AudioStreamPlayer) -> void:
	play_sound(player,SOUND_SELECT_BUTTON)

func play_next_click(player: AudioStreamPlayer) -> void:
	play_sound(player,SOUND_SELECT_TILE)

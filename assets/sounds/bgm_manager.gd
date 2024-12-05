extends Node

@onready var hit_player: AudioStreamPlayer = $HIT_Player
@onready var ambient_player: AudioStreamPlayer = $Ambient_Player

const AMBIENT_LOOP = [
	preload("res://assets/sounds/ambient/loop/01_Amajor9_LOOP_seamless_MIXED.ogg"),
	preload("res://assets/sounds/ambient/loop/02_Cmajor9_LOOP_seamless_MIXED.ogg"),
	preload("res://assets/sounds/ambient/loop/03_G#maj9_LOOP_seamless_MIXED.ogg"),
	preload("res://assets/sounds/ambient/loop/04_Aminor9_LOOP_seamless_MIXED.ogg")
]
const AMBIENT_HIT = [
	preload("res://assets/sounds/ambient/hit/01_Amajor9_HIT.ogg"),
	preload("res://assets/sounds/ambient/hit/02_Cmajor9_HIT.ogg"),
	preload("res://assets/sounds/ambient/hit/03_G#maj9_HIT.ogg"),
	preload("res://assets/sounds/ambient/hit/04_Aminor9_HIT.ogg")
]

var _phase : int = -1

func play_next_phase():
	_phase += 1
	if _phase > AMBIENT_HIT.size()-1:
		_phase = 0
	
	hit_player.stream = AMBIENT_HIT[_phase]
	hit_player.play()
	ambient_player.stream = AMBIENT_LOOP[_phase]
	ambient_player.play()

func stop():
	hit_player.stop()
	ambient_player.stop()

#func play_initial_ambient_loop_only(loop: AudioStreamPlayer):
	#loop.stop()
	#loop.stream = AMBIENT_LOOP[3]
	#loop.play()
#
#func play_ambient_hit(loop: AudioStreamPlayer, hit: AudioStreamPlayer):
	#hit.stop()
	#hit.stream = AMBIENT_HIT[_phase]
	#hit.play()
	#
	#loop.stop()
	#loop.stream = AMBIENT_LOOP[_phase]
	#loop.play()
	##next_ambient_phase()
	
	
#const AMBIENT_LOOP_PLAYLIST : AudioStreamPlaylist = preload("res://assets/sounds/ambient/ambient_loop_playlist.tres")
#func play_next_phase():
	#play(AMBIENT_LOOP_PLAYLIST.get_list_stream(_phase))

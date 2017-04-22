extends Node2D

const TIME_PAUSE  = 0
const TIME_PLAY   = 1
const TIME_FF1    = 2
const TIME_FF2    = 3

export var time_scale = TIME_PLAY

func _on_play_button_toggled(pressed):
	time_scale = TIME_PLAY

func _on_pause_button_toggled( pressed ):
	time_scale = TIME_PAUSE

func _on_ff1_button_toggled( pressed ):
	time_scale = TIME_FF1

func _on_ff2_button_toggled( pressed ):
	time_scale = TIME_FF2

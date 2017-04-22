extends Node2D

const TIME_PAUSE  = 0
const TIME_PLAY   = 1
const TIME_FF1    = 2
const TIME_FF2    = 4

export var time_scale = TIME_PLAY

signal timescale_changed(x)

var clock

func _ready():
	clock = get_node('./clock')

func set_timescale(x):
	time_scale = x
	emit_signal('timescale_changed', x)

func _on_play_button_toggled(pressed):
	set_timescale(TIME_PLAY)

func _on_pause_button_toggled( pressed ):
	set_timescale(TIME_PAUSE)

func _on_ff1_button_toggled( pressed ):
	set_timescale(TIME_FF1)

func _on_ff2_button_toggled( pressed ):
	set_timescale(TIME_FF2)

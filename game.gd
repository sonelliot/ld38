extends Node2D

const TIME_PAUSE  = 0
const TIME_PLAY   = 1
const TIME_FF1    = 2
const TIME_FF2    = 4

const MODE_NORMAL = 0
const MODE_CLEAN  = 1

export var time_scale = TIME_PLAY

signal timescale_changed(x)

var clock
var broom_texture
var mode

onready var clean_button = get_node('./clean_button')

func change_mode(m):
	mode = m
	Globals.set('mode', m)

func mode_clean():
	if Input.is_action_pressed("mode_cancel"):
		change_mode(MODE_NORMAL)
		clean_button.show()
		Input.set_custom_mouse_cursor(null)

func _ready():
	clock = get_node('./clock')
	broom_texture = load('res://sprites/broom-cursor.png')
	broom_texture.set_flags(0)
	change_mode(MODE_NORMAL)
	set_timescale(TIME_PLAY)
	set_process(true)

func _process(delta):
	if mode == MODE_CLEAN:
		mode_clean()

func get_timescale():
	return time_scale

func set_timescale(x):
	time_scale = x
	Globals.set('timescale', x)
	emit_signal('timescale_changed', x)

func _on_play_button_toggled(pressed):
	set_timescale(TIME_PLAY)
	get_tree().set_pause(false)

func _on_pause_button_toggled( pressed ):
	set_timescale(TIME_PAUSE)
	get_tree().set_pause(true)

func _on_ff1_button_toggled( pressed ):
	set_timescale(TIME_FF1)
	get_tree().set_pause(false)

func _on_ff2_button_toggled( pressed ):
	set_timescale(TIME_FF2)
	get_tree().set_pause(false)

func _on_clean_button_pressed():
	Input.set_custom_mouse_cursor(broom_texture, Vector2(24,24))
	clean_button.hide()
	change_mode(MODE_CLEAN)
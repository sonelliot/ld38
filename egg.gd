extends Node2D

export var species = ''
export var incubation_period = 60 # sec

var world
var alive_for = 0

func spawn():
	pass

func _ready():
	set_process(true)

func _process(delta):
	var timescale = Globals.get('timescale')
	
	var anim = get_node('./anim')
	anim.set_speed(timescale)
	
#	alive_for = alive_for + timescale * delta
#	if alive_for > incubation_period:
#		print('spawn')
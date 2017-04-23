extends Node2D

export var species = ''
export var incubation_period = 60 # sec

var world
var alive_for = 0
var critter

func spawn():
	var c = critter.instance()
	get_parent().add_child(c)
	c.set_global_pos(get_global_pos())
	queue_free()

func _ready():
	critter = load("res://" + species + ".tscn")
	set_process(true)

func _process(delta):
	var timescale = Globals.get('timescale')
	
	var anim = get_node('./anim')
	anim.set_speed(timescale)
	
	alive_for = alive_for + timescale * delta
	if alive_for > incubation_period:
		spawn()
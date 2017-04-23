extends Node2D

export var species = ''
export var incubation_period = 60 # sec

var world
var alive_for = 0
var critter

func spawn():
	var c = critter.instance()
	get_parent().add_child(c)
	
	var offset = 0
	if species == 'bugtiger':
		offset = -20
	
	var pos = get_global_pos()
	pos = pos + Vector2(0, offset)
	
	c.set_global_pos(pos)

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
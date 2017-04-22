extends Node2D

func _ready():
	set_process(true)

func _process(delta):
	var timescale = Globals.get('timescale')
	
	var anim = get_node('./anim')
	anim.set_speed(timescale)
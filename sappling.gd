extends Node2D

const GROWTH_SAPPLING = 0
const GROWTH_SPROUTED = 1
const GROWTH_MATURE   = 2

export var growth_rate = 1.0

var growth = 0
var growth_state = GROWTH_SAPPLING
var fruitling_scene = load("res://fruitling.tscn")

var slots = []

func is_mature():
	return growth_state == GROWTH_MATURE

func mature_plant():
	if growth > 100:
		growth = 0
		growth_state = growth_state + 1
		get_node("sprite").set_frame(growth_state)

func mature_fruit():
	var n = int(growth / 100)
	while n > 0:
		for s in slots:
			if s.get_child_count() == 0:
				var f = fruitling_scene.instance()
				s.add_child(f)
				growth = growth - 100
				break
		n = n - 1

func _ready():
	for child in get_children():
		if child.get_name().begins_with('slot'):
			slots.append(child)
	
	set_process(true)

func _process(delta):
	var timescale = Globals.get('timescale')
	var adj_delta = delta * timescale
	
	growth = min(growth + (adj_delta * growth_rate), slots.size() * 100)
	
	if not is_mature():
		mature_plant()
	else:
		mature_fruit()



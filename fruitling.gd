extends Node2D

export var growth_time = 20

var fruit_scene = load("res://apple.tscn")
var timer = 0
onready var sprite = get_node("./sprite")

const START_SCALE  = 1
const FINISH_SCALE = 3

func _ready():
	set_process(true)

func _process(delta):
	var timescale = Globals.get("timescale")
	var adj_delta = delta * timescale
	
	timer = timer + adj_delta
	
	var perc = timer / growth_time
	var scl = START_SCALE + perc * (FINISH_SCALE - START_SCALE)
	
	sprite.set_scale(Vector2(scl, scl))
	
	if timer > growth_time:
		var w = get_tree().get_root().get_node("world")
		var f = fruit_scene.instance()
		w.add_child(f)
		f.set_global_pos(get_global_pos())
		f.apply_impulse(Vector2(0,0), Vector2(randf() * 2 - 1, -1).normalized() * 60)
		self.queue_free()
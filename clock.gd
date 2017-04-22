extends Node2D

func _ready():
	var world = get_tree().get_root().get_node('world')
	world.connect("timescale_changed", self, "_on_timescale_changed")

func _on_timescale_changed(x):
	var anim = get_node('./anim')
	anim.set_speed(x)
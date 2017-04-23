extends RigidBody2D

func _ready():
	set_process(true)

func _process(delta):
	var timescale = Globals.get('timescale')
	get_node("anim").set_speed(timescale)

func _on_button_pressed():
	if Globals.get('mode') == 1:
		queue_free()
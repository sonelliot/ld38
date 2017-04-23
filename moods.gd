extends Sprite

const MOOD_HAPPY   = 0
const MOOD_GRUMPY  = 1
const MOOD_SICK    = 2
const MOOD_HUNGRY  = 3

const MODE_TEMPORARY = 0
const MODE_PERMANENT = 1

var timer = 0
var timeout = 0
var mode = MODE_TEMPORARY

func set_mood(m):
	if m >= MOOD_HAPPY and m <= MOOD_HUNGRY:
		set_frame(m)

func show_mood_for(m, t):
	if is_visible() and timeout > 0 and mode != MODE_PERMANENT:
		return # already doing stuff
	
	mode = MODE_TEMPORARY
	
	set_mood(m)
	show()
	
	timer = 0
	timeout = t

func show_mood(m):
#	if is_visible() and mode == MODE_PERMANENT:
#		return # already OK
	
	mode = MODE_PERMANENT
	set_mood(m)
	show()

func _ready():
	hide()
	
	set_process(true)

func _process(delta):
	var timescale = Globals.get('timescale')
	var adj_delta = delta * timescale
	
	if mode == MODE_TEMPORARY and is_visible():
		timer = timer + adj_delta
		if timer > timeout:
			hide()
			timer = 0; timeout = 0
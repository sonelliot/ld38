extends KinematicBody2D

const STATE_IDLE   = 0
const STATE_EAT    = 1
const STATE_WANDER = 2
const STATE_DEATH  = 3
const STATE_POOP   = 4

export var idle_timeout = 10
export var wander_timeout = 5
export var speed = 5
export var eat_speed = 1
export var sight_distance = 30
export var hunger_rate = 0.5
export var starve_rate = 1.0

var hunger = 100
var poop   = 0
var health = 80

var state = STATE_IDLE
var facing = Vector2(1, 0)
var anim
var timer = 0
var food

onready var moods = get_node('./moods')
onready var poop_scene = load('res://poop.tscn')

func play_anim(n):
	if anim.get_current_animation() != n:
		anim.play(n)

func eat(n):
	hunger = max(100, hunger + n)
	poop   = min(100, poop + n)

func is_food(obj):
	if not obj.has_meta('food'):
		return false
	
	var n = obj.get_meta('food')
	return n == 'apple'

func hungry():
	return hunger < 80

func starving():
	return hunger < 20

func need_to_poo():
	return poop > 30

func look_for_food():
	for node in get_parent().get_children():
		if  is_food(node) and \
			get_pos().distance_to(node.get_pos()) < sight_distance:
			food = node
			return

func near_food():
	return get_pos().distance_to(food.get_pos()) < 10

func state_idle(delta):
	play_anim("idle")
	
	if need_to_poo():
		state = STATE_POOP
	
	if timer > idle_timeout:
		state = STATE_WANDER
		timer = 0
		facing.x = facing.x * -1 if randf() < 0.5 else 1

func state_wander(delta):
	play_anim("idle")
	
	if need_to_poo():
		state = STATE_POOP
	
	if food == null:
		look_for_food()
	
	if food != null:
		# move in direction of food
		facing.x = sign((food.get_pos() - get_pos()).x)
		
		if near_food():
			moods.show_mood_for(moods.MOOD_HAPPY, 8)
			state = STATE_EAT
			timer = 0
		
	elif timer > wander_timeout:
		state = STATE_IDLE
		timer = 0
	
	move(facing * speed * delta)

func state_eat(delta):
	if food != null:
		play_anim("eat")
		var amt = eat_speed * delta
		
		food.bite(amt)
		eat(amt)
		
		if food.eaten():
			food.queue_free()
			food = null
		
	else:
		state = STATE_IDLE
		timer = 0

func state_poop(delta):
	play_anim('poop')
	
	if not anim.is_playing():
		var p = poop_scene.instance()
		get_parent().add_child(p)
		p.set_global_pos(get_global_pos())
		p.apply_impulse(Vector2(0,0), Vector2(sign(randf() * 2 - 1), 0) * 60)
		
		state = STATE_IDLE
		poop = 0

func state_death(delta):
	play_anim('death')
	
	if not anim.is_playing():
		self.queue_free()

func update_mood_icon():
	if health < 50:
		moods.show_mood(moods.MOOD_SICK)
	elif hunger < 50:
		moods.show_mood(moods.MOOD_HUNGRY)

func _ready():
	set_process(true)
	
	anim = get_node('./anim')

func _process(delta):
	var timescale = Globals.get('timescale')
	var adj_delta = delta * timescale
	
	var timescale = Globals.get('timescale')
	anim.set_speed(timescale)
	
	timer = timer + adj_delta
	hunger = hunger - (hunger_rate * adj_delta)
	
	update_mood_icon()
	
	if starving():
		health = health - (starve_rate * adj_delta)
	
	if health <= 0:
		state = STATE_DEATH
	
	if state == STATE_IDLE:
		state_idle(adj_delta)
	elif state == STATE_EAT:
		state_eat(adj_delta)
	elif state == STATE_POOP:
		state_poop(adj_delta)
	elif state == STATE_WANDER:
		state_wander(adj_delta)
	elif state == STATE_DEATH:
		state_death(adj_delta)
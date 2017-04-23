extends Node2D

export var nutrition = 10
export var type = ''

var locked = false

func _ready():
	set_meta('food', type)

func eaten():
	return nutrition <= 0

func bite(amount):
	nutrition = nutrition - amount

func lock():
	locked = true

func unlock():
	locked = false

func is_locked():
	return locked